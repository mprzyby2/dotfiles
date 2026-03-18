# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
#
# Use VSCode instead of neovim as your default editor
# export EDITOR="code"
#
# Set a custom prompt with the directory revealed (alternatively use https://starship.rs)
# PS1="\W \[\e]0;\w\a\]$PS1"
alias typora="typora --disable-gpu --enable-wayland-ime"

# tat: tmux attach
function tat {
  name=$(basename $(pwd) | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}

eval "$(direnv hook bash)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# fzf alt+c hidden directories toggle binding alt+h
export FZF_ALT_C_COMMAND="fd --type d --no-hidden"
export FZF_ALT_C_OPTS="
  --header 'ALT-H: toggle hidden'
  --prompt 'dirs> '
  --bind 'alt-h:transform:
    if [[ \$FZF_PROMPT == \"dirs> \" ]]; then
      echo \"change-prompt(dirs+hidden> )+reload(fd --type d --hidden --exclude .git)\"
    else
      echo \"change-prompt(dirs> )+reload(fd --type d --no-hidden)\"
    fi'
"

# FZF ctrl+t — wklejanie pliku/katalogu, ALT-H toggle hidden
export FZF_CTRL_T_COMMAND="fd --no-hidden"
export FZF_CTRL_T_OPTS="
  --header 'ALT-H: toggle hidden'
  --prompt 'files> '
  --bind 'alt-h:transform:
    if [[ \$FZF_PROMPT == \"files> \" ]]; then
      echo \"change-prompt(files+hidden> )+reload(fd --hidden --exclude .git)\"
    else
      echo \"change-prompt(files> )+reload(fd --no-hidden)\"
    fi'
"


alias dirs="dirs -v -l"

# yazi y function to quit in currently selected directory
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
