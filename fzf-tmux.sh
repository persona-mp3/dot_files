#!/usr/bin/env zsh

# fzf_conf="fzf"
# clusterfk=$(tmux list-windows -a -F '#{session_name}_#{window_name}')
#
# tmux_fzf(){
#     selected=$(echo "$clusterfk" | awk -F'_' '{print $2}' | $fzf_conf --height=70% --margin=20% --border)
#     [[ -z "$selected" ]] && return
#
#     # Look up the session for the chosen window name
#     session=$(echo "$clusterfk" | awk -F'_' -v w="$selected" '$2 == w {print $1; exit}')
#
#     tmux switch-client -t "${session}:${selected}"
# }
#
# alias tfind="tmux_fzf"

#!/usr/bin/env zsh
fzf_conf="fzf"
clusterfk=$(tmux list-windows -a -F '#{session_name}_#{window_name}')

tmux_fzf(){
    selected=$(echo "$clusterfk" | awk -F'_' '{
        if ($2 == "zsh") print "* " $1 "_" $2
        else print "  " $2
    }' | $fzf_conf --height=70% --margin=20% --border)
    [[ -z "$selected" ]] && return

    # strip marker, extract session/window
    clean="${selected#\* }"
    clean="${clean#"  "}"
    
    if [[ "$selected" == \** ]]; then
        session="${clean%%_*}"
        window="${clean#*_}"
    else
        session=$(echo "$clusterfk" | awk -F'_' -v w="$clean" '$2 == w {print $1; exit}')
        window="$clean"
    fi

    tmux switch-client -t "${session}:${window}"
}

alias tf="tmux_fzf"
