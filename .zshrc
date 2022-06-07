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

# Exports
export CFLAGS="-O2 -g -fno-stack-check"
export KERL_CONFIGURE_OPTIONS="--disable-hipe --with-ssl=$(brew --prefix openssl) --with-wx-config=$(brew --prefix wxwidgets)/bin/wx-config --with-odbc=$(brew --prefix unixodbc)"
export CPPFLAGS="-I$(brew --prefix unixodbc)/include"
export LDFLAGS="-L$(brew --prefix unixodbc)/lib"

# ASDF
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vim='nvim'
