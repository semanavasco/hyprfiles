# Arch Linux x Hyprland Dotfiles

## `🖼️` Preview :
> *Need to take some screenshots.*

## `📦` Requirements :
> 1. **Pacman :**
> ```bash
> sudo pacman -S firefox thunar gvfs lazygit fzf ripgrep pamixer unzip dotnet-runtime dotnet-sdk dunst wl-clipboard wev swww brightnessctl power-profiles-daemon ruby zsh hyprlock waybar neofetch nwg-look neovim curl git cliphist pavucontrol github-cli bluez bluez-utils blueman 
> ```
> ```bash
> sudo pacman -R dolphin 
> ```
> *+ remove dolphin config files*
> 
> 2. **AUR (Arch User Repository) :**
> *I use [YAY](https://github.com/Jguer/yay), but feel free to use any other AUR Helper.*
> ```bash
> yay -S grimblast webcord noto-fonts-cjk ttf-joypixels spotify-launcher oh-my-posh waypaper catppuccin-gtk-theme-mocha nbfc-linux
> ```
> 3. **Other Requirements :**
> - [ohmyzsh](https://ohmyz.sh/)
> - zsh-autosuggestions & zsh-syntax-highlighting plugins :
>   ```bash
>   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
>   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
>   ```
> - [colorls](https://github.com/athityakumar/colorls) :
>   ```bash
>   sudo gem install colorls
>   gem install colorls
>   ```
> - [asdf](https://asdf-vm.com/)
> - [node](https://nodejs.org/en) :
>   ```bash
>   asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
>   asdf install nodejs latest
>   ```
> - FiraCode Nerd Font :
>   ```bash
>   oh-my-posh font install FiraCode
>   ```
> 
> *These requirements are needed if you want an identical setup, feel free to install the ones you need and to edit the config files accordingly.*
