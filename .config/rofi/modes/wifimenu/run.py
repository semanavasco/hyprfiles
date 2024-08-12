import re
import subprocess

# Customization
config_file = "$HOME/.config/rofi/modes/wifimenu/selector/config.rasi"
password_config_file = "$HOME/.config/rofi/modes/wifimenu/password/config.rasi"

error_img = "$HOME/.config/rofi/modes/wifimenu/assets/error.png"
loading_img = "$HOME/.config/rofi/modes/wifimenu/assets/loading.png"
repeat_img = "$HOME/.config/rofi/modes/wifimenu/assets/repeat.png"
success_img = "$HOME/.config/rofi/modes/wifimenu/assets/wifi.png"

active = ""
known = ""

dunst_id = "5510"
dunst_app = "WiFi"

# Getting all of the available connections
available_connections = subprocess.run(
    "nmcli --fields 'IN-USE,SSID,BARS' device wifi list | sed s/\\*//g",
    shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True,
)

if available_connections.stderr:
    subprocess.run(
        f'dunstify -r {dunst_id} -a {dunst_app} -i {error_img} "Wi-Fi Menu Says :" "Error : {available_connections.stderr}"',
        shell=True,
    )
    quit()

available_connections = available_connections.stdout.split("\n")

# Getting all of the known connections, this will remove the need of typing the password every time you connect to a known network
known_connections = subprocess.run(
    "nmcli connection show",
    shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True,
)

if known_connections.stderr:
    subprocess.run(
        f'dunstify -r {dunst_id} -a {dunst_app} -i {error_img} "Wi-Fi Menu Says :" "Error : {known_connections.stderr}"',
        shell=True,
    )
    quit()

known_connections = re.findall(
    r"^(.*?)\s+[a-f0-9\-]+\s+wifi\s", known_connections.stdout, re.MULTILINE
)

# Variables
seen_ssids = []  # Avoids duplicates (stores the SSID with no special characters, etc)
known_entries = []  # Used to place all known entries at the top
entries = []  # Used to build the rofi entries

# Adding the header to the top of the display
entries.append(available_connections[0].replace("IN-USE", "STATUS"))
available_connections.pop(0)

# Entries logic
for connection in available_connections:
    # Normalizing the SSIDs
    ssid = connection.rstrip().rsplit("  ", 1)[0].strip()

    # Ignoring this type of SSIDs (add more with the or operator)
    if ssid == "--" or ssid == "":
        continue

    # Checking for the currently active network
    if f"{active}" in ssid:
        ssid = ssid.replace(f"{active}       ", "")

        if ssid in seen_ssids:
            entries.pop(seen_ssids.index(ssid) + 1)
        else:
            seen_ssids.append(ssid)

        entries.insert(1, connection)
        continue

    # Ignoring seen SSIDs
    if ssid in seen_ssids:
        continue

    # Add the  icon if the connection is known
    if ssid in known_connections:
        known_entries.append(f"{known}" + connection.removeprefix(" "))
    else:
        entries.append(connection)

    seen_ssids.append(ssid)

# Pushing known entries to the top of the entries list
for entry in known_entries:
    entries.insert(2 if entries[1].startswith(f"{active}") else 1, entry)

# Normalizing entries so that they all are 40 characters long
for index, entry in enumerate(entries):
    ssid = entry[8:-7].strip()
    length = len(ssid)

    if length < 26:
        ssid += " " * (26 - length)
    elif length > 26:
        ssid = ssid[: -(length - 22)] + "..." + " " * (length - 30)

    entries[index] = entry.replace(entry[8:-6], ssid)

# Display the Wi-Fi selector
selected = subprocess.run(
    f"echo -e \"{"\n".join(entries)}\" | rofi -i -p \"  WiFi\" -config {config_file} -dmenu",
    shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True,
)

# If unidentified error occurs, quit and notify the error
if selected.stderr:
    subprocess.run(
        f'dunstify -r {dunst_id} -a {dunst_app} -i {error_img} "{selected} says :" "Unidentified Error : {selected.stderr}"',
        shell=True,
    )
    quit()

if (
    selected.stdout == ""
    or "STATUS  SSID                       BARS" in selected.stdout
):
    subprocess.run(
        f'dunstify -r {dunst_id} -a {dunst_app} -i {error_img} "Wi-Fi Manager says :" "This network does not exist."',
        shell=True,
    )
    quit()

# Normalizing the selected SSID
selected = selected.stdout.rstrip().rsplit("  ", 1)[0].strip()

# Display the connection manager menu if the connection is known or active
if selected.startswith(f"{active}") or selected.startswith(f"{known}"):
    options = (
        ["Disconnect", "Show connection password", "Forget connection", "Exit"]
        if selected.startswith(f"{active}")
        else ["Connect", "Show connection password", "Forget connection", "Exit"]
    )

    selected = selected.replace(f"{active}       ", "").replace(f"{known}       ", "")

    option = subprocess.run(
        f'echo -e "{"\n".join(options)}" | rofi -p "  {selected}" -config {config_file} -dmenu',
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )

    # If unidentified error occurs, quit and notify the error
    if option.stderr:
        subprocess.run(
            f'dunstify -r {dunst_id} -a {dunst_app} -i {error_img} "{selected} says :" "Unidentified Error : {option.stderr}"',
            shell=True,
        )
        quit()

    option = option.stdout.removesuffix("\n")
    # If user presses "ESCAPE"
    if option == "":
        option = "Exit"

    match option:
        case "Connect":
            subprocess.run(
                f'dunstify -r {dunst_id} -a {dunst_app} -i {loading_img} "Connecting to \\"{selected}\\"..."',
                shell=True,
            )

            success = subprocess.run(
                f'nmcli dev wifi con "{selected}"',
                shell=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
            )

            # Handling errors
            if success.stderr:
                if "The Wi-Fi network could not be found" in success.stderr:
                    subprocess.run(
                        f'dunstify -r {dunst_id} -a {dunst_app} -i {repeat_img} "{selected} says :" "The Wi-Fi network could not be found. Try again."',
                        shell=True,
                    )
                    quit()

            # Success
            subprocess.run(
                f'dunstify -r {dunst_id} -a {dunst_app} -i {success_img} "Connected :" "You are now connected to {selected}"',
                shell=True,
            )
            quit()

        case "Disconnect":
            subprocess.run(
                f'dunstify -r {dunst_id} -a {dunst_app} -i {error_img} "{selected} says :" "You have been disconnected." ; nmcli device disconnect wlan0',
                shell=True,
            )
            quit()

        case "Show connection password":
            password = subprocess.run(
                f'nmcli --show-secrets connection show "{selected}" | grep 802-11-wireless-security.psk:',
                shell=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
            )

            if password.stderr:
                subprocess.run(
                    f'dunstify -r {dunst_id} -a {dunst_app} -i {error_img} "{selected} says :" "Could not get WiFi password."',
                    shell=True,
                )
                quit()

            password = password.stdout.replace(
                "802-11-wireless-security.psk:           ", ""
            )

            subprocess.run(
                f'dunstify -r {dunst_id} -a {dunst_app} -i {success_img} "{selected} says :" "WiFi password : {password}"',
                shell=True,
            )
            quit()

        case "Forget connection":
            subprocess.run(
                f'dunstify -r {dunst_id} -a {dunst_app} -i {error_img} "{selected} says :" "Connection forgotten." ; nmcli connection delete "{selected}"',
                shell=True,
            )
            quit()

        case "Exit":
            quit()

        # Invalid option
        case _:
            subprocess.run(
                f'dunstify -r {dunst_id} -a {dunst_app} -i {error_img} "{selected} says :" "Unknown option : \\"{option}\\""',
                shell=True,
            )
            quit()

# Getting password
password = subprocess.run(
    f'echo -e " " | rofi -password -p "  Password" -config {password_config_file} -dmenu',
    shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True,
)

# If unidentified error occurs, quit and notify the error
if password.stderr:
    subprocess.run(
        f'dunstify -r {dunst_id} -a {dunst_app} -i {error_img} "{selected} says :" "Unidentified Error : {password.stderr}"',
        shell=True,
    )
    quit()

password = password.stdout.strip()

# Connecting message
subprocess.run(
    f'dunstify -r {dunst_id} -a {dunst_app} -i {loading_img} "Connecting to \\"{selected}\\"..."',
    shell=True,
)

# Attempting to connect using password
success = subprocess.run(
    f'nmcli dev wifi con "{selected}" password "{password}"',
    shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True,
)

# Handling errors
if success.stderr:
    if "The Wi-Fi network could not be found" in success.stderr:
        subprocess.run(
            f'dunstify -r {dunst_id} -a {dunst_app} -i {repeat_img} "{selected} says :" "The Wi-Fi network could not be found. Try again." ; nmcli connection delete "{selected}"',
            shell=True,
        )
    elif "Secrets were required, but not provided" in success.stderr:
        subprocess.run(
            f'dunstify -r {dunst_id} -a {dunst_app} -i {error_img} "{selected} says :" "Wrong password, could not connect !" ; nmcli connection delete "{selected}"',
            shell=True,
        )
    else:
        subprocess.run(
            f'dunstify -r {dunst_id} -a {dunst_app} -i {error_img} "{selected} says :" "Error : {success.stderr}"',
            shell=True,
        )
    quit()

# Success
subprocess.run(
    f'dunstify -r {dunst_id} -a {dunst_app} -i {success_img} "Connected :" "You are now connected to {selected}"',
    shell=True,
)
