import subprocess

options = "\n\n\n"
config_file = "$HOME/.config/rofi/modes/powermenu/config.rasi"

selected = subprocess.run(
    f'echo -e "{options}" | rofi -config {config_file} -dmenu',
    shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True,
)

if selected.stderr:
    print(selected.stderr)
    quit()

match selected.stdout.strip():
    case "":
        subprocess.run("poweroff", shell=True)
    case "":
        subprocess.run("reboot", shell=True)
    case "":
        subprocess.run("hyprlock", shell=True)
    case "":
        # Add a logout script.
        pass
    case _:
        quit()
