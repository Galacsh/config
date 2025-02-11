# etc
alias cd="z"

# git
alias ga="git add"
alias gall="git add -A"
alias gcm="git commit -m"
alias gs="git status"

# tmux
function tmux_start_session() {
  # Get a list of tmux sessions
  local sessions=$(tmux list-sessions -F "#S" 2>/dev/null)
  
  if [[ $# -gt 0 ]]; then
    tmux new-session -A -s "$*"
  elif [[ -z $sessions ]]; then
    tmux new-session
  else
    # Sessions available, select one to attach to
    local session=$(echo "$sessions" | fzf )

    if [[ -n $session ]]; then
      tmux attach-session -t "$session"
    else
      echo "No session selected."
    fi
  fi
}

function tmux_kill_sessions() {
    local sessions=$(tmux list-sessions -F "#S" 2>/dev/null)
    
    if [[ -z $sessions ]]; then
        echo "Nothing to kill."
    else
        local session=$(echo "$sessions" | fzf -m )

        if [[ -n $session ]]; then
            echo "Killed following session(s):"
            echo "$session" | while read -r s; do
              tmux kill-session -t "$s" && printf '\t%s\n' "$s" || printf 'Cannot kill "%s"\n' "$s"
            done
        else
            echo "No session selected."
        fi
    fi
}

alias ts="tmux_start_session"
alias tk="tmux_kill_sessions"

