export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=( git zsh-syntax-highlighting zsh-autosuggestions )

source $ZSH/oh-my-zsh.sh
. "$HOME/.asdf/asdf.sh"

export PATH=$PATH:/home/svasco/.spicetify
export PATH=$PATH:/home/svasco/.local/share/gem/ruby/3.0.0/bin

if [ -x "$(command -v colorls)" ]; then
    alias ls="colorls"
    alias la="colorls -al"
fi

echo "\n$(neofetch)    󰅭 Working on $(pwd)\n"
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/catppuccin.omp.json)"
