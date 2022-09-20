# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

export EDITOR=vim
export _JAVA_AWT_WM_NONREPARENTING=1

export PATH="$PATH":"$HOME"/.cargo/bin

alias dotfiles='/usr/bin/git --git-dir=$HOME/git/dotfiles/ --work-tree=$HOME'

# opam configuration
[[ ! -r /home/ad/.opam/opam-init/init.zsh ]] || source /home/ad/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
