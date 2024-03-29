# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH="$HOME/.zsh"
# Plugins cloned via git
PLUGINS=(
  powerlevel10k
  forgit
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# modify PATH
export PATH="/home/lutz/.local/bin:$PATH"

# Add googles adb platform tools
if [ -d "$HOME/.adb" ] ; then
    PATH="$HOME/.adb:$PATH"
fi

# Use qgnomeplatform as theme for qt applications
# QT_QPA_PLATFORMTHEME='gnome'

# Enable colors:
autoload -U colors && colors
PS1="%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$ "

# Custom Variables
EDITOR=nano

# Enable options
setopt autocd			# no cd required
setopt noclobber		# stop when overriding files
setopt cdablevars		# make vars cd-able
setopt interactivecomments	# enable commenting in interactive shell

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.cache/.zsh_history"
setopt appendhistory
setopt histignoredups

# Custom ZSH Binds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

# Load aliases and scripts if existent.
[ -f "$HOME/.zsh_aliases" ] && source "$HOME/.zsh_aliases"
for f in "$ZSH"/scripts/*(.)
  source $f;


# Load plugins (if existend) ; should be last.
# first plugins not installed via git
_ZO_ECHO=1							# Print dir before jumping to it
! command -v zoxide >/dev/null 2>&1 || eval "$(zoxide init zsh)" 	# use --cmd j flag to change z to j
[[ -f "/etc/zsh_command_not_found" ]] && source "/etc/zsh_command_not_found"

# than everything in PLUGINS
for p in $PLUGINS; do
  [[ -f $ZSH/$p/$p.zsh ]] && source $ZSH/$p/$p.zsh
  [[ -f $ZSH/$p/$p.plugin.zsh ]] && source $ZSH/$p/$p.plugin.zsh
  [[ -f $ZSH/$p/$p.zsh-theme ]] && source $ZSH/$p/$p.zsh-theme;
done

# add alias for updating zsh plugins
alias update-zsh-plugins='zsh-update $PLUGINS'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

[ -f "/home/lutz/.ghcup/env" ] && source "/home/lutz/.ghcup/env" # ghcup-env

true


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lutz/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lutz/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/lutz/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/lutz/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

