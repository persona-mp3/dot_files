#!/usr/bin/env bash

fzf_sessions(){
	environment=$(env | grep TMUX)
	target=$(tmux ls | cut -d: -f1 | fzf --style "full" --header "Session Finder" --margin 10%)

	if [[ -z "$environment" ]]; then
		echo "not in a tmux environment"
		return
	fi

	if [[ -z "$target" ]]; then
		return
	fi

	tmux switch-client -t $target
}

fzf_sessions

