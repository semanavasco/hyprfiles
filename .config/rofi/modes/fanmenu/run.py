import subprocess

# Customization
config_file = "$HOME/.config/rofi/modes/fanmenu/config.rasi"
status_file = "/home/svasco/.config/rofi/modes/fanmenu/status.txt"

options = "󰠝\n󰈐\n󰌪\n󰗑\n"

# Get the current status
current_status = ""
with open(status_file, "r") as status:
    current_status = status.readline().strip()

# Display the modes selector
selected = subprocess.run(
    f'echo -en "{options}" | rofi -config {config_file} -dmenu -select "{current_status}"',
    shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True,
)

if selected.stderr:
    print(selected.stderr)
    quit()

selected = selected.stdout.strip()

match selected:
    case "󰠝":
        subprocess.run(f'nbfc set -s 0 | echo "{selected}" > {status_file}', shell=True)
    case "󰈐":
        subprocess.run(f'nbfc set -a | echo "{selected}" > {status_file}', shell=True)
    case "󰌪":
        subprocess.run(
            f'nbfc set -s 30 | echo "{selected}" > {status_file}', shell=True
        )
    case "󰗑":
        subprocess.run(
            f'nbfc set -s 65 | echo "{selected}" > {status_file}', shell=True
        )
    case "":
        subprocess.run(
            f'nbfc set -s 100 | echo "{selected}" > {status_file}', shell=True
        )
    case _:
        quit()
