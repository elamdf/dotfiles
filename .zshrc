# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# gimmie my go programz
export PATH=$PATH:/home/elamd/go/bin/
export KISYS3DMOD=/usr/share/kicad-nightly/3dmodels/
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export JAVA_HOME=/usr/lib/jvm/default
export PYTHONPATH=/usr/lib/python3.9/site-packages/
# Enable colors and change prompt:
 autoload -U colors && colors
 PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
#
# # History in cache directory:
 HISTSIZE=10000
 SAVEHIST=10000
 HISTFILE=~/.cache/zsh/history
#
# # Basic auto/tab complete:
 autoload -U compinit
 zstyle ':completion:*' menu select
 zmodload zsh/complist
 compinit
 _comp_options+=(globdots)		# Include hidden files.

# # vi mode
 bindkey -v
 export KEYTIMEOUT=1
#
# # Use vim keys in tab complete menu:
 bindkey -M menuselect 'h' vi-backward-char
 bindkey -M menuselect 'k' vi-up-line-or-history
 bindkey -M menuselect 'l' vi-forward-char
 bindkey -M menuselect 'j' vi-down-line-or-history
 bindkey -v '^?' backward-delete-char
#
# # Change cursor shape for different vi modes.
 function zle-keymap-select {
   if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]]; then
            echo -ne '\e[1 q'
              elif [[ ${KEYMAP} == main ]] ||
                     [[ ${KEYMAP} == viins ]] ||
                            [[ ${KEYMAP} = '' ]] ||
                                   [[ $1 = 'beam' ]]; then
                                       echo -ne '\e[5 q'
                                         fi
                                         }
                                         zle -N zle-keymap-select
                                         zle-line-init() {
                                             zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
                                                 echo -ne "\e[5 q"
                                                 }
                                                 zle -N zle-line-init
                                                 echo -ne '\e[5 q' # Use beam shape cursor on startup.
                                                 preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

                                                 # Use lf to switch directories and bind it to ctrl-o
                                                 lfcd () {
                                                     tmp="$(mktemp)"
                                                         lf -last-dir-path="$tmp" "$@"
                                                             if [ -f "$tmp" ]; then
                                                                     dir="$(cat "$tmp")"
                                                                             rm -f "$tmp"
                                                                                     [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
                                                                                         fi
                                                                                         }
                                                                                         bindkey -s '^o' 'lfcd\n'

                                                                                         # Edit line in vim with ctrl-e:
                                                                                         autoload edit-command-line; zle -N edit-command-line
                                                                                         bindkey '^e' edit-command-line

                                                                                         # Load aliases and shortcuts if existent.
                                                                                         [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
                                                                                         [ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

#                                                                                         # Load zsh-syntax-highlighting; should be last.
                                                                                         source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/elamd/.local/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/home/elamd/.local/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/elamd/.local/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/elamd/.local/bin/google-cloud-sdk/completion.zsh.inc'; fi
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
