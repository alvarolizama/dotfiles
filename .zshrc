# OMHYZSH
ZSH=~/.oh-my-zsh
plugins=(brew common-aliases docker docker-compose git git-flow git-hubflow github mix macos tig web-search)
source $ZSH/oh-my-zsh.sh
source $HOME/.extra.sh

# Direnv
eval "$(direnv hook zsh)"

# Startship prompt
eval "$(starship init zsh)"

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# ASDF
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vim='nvim'
