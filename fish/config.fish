if status is-interactive
# Commands to run in interactive sessions can go here
end

alias src="source ~/.config/fish/config.fish" && echo " Do you know who else sources their config instead of working?"

alias v=nvim
alias dev="cd ~/dev"
alias idea="cd ~/ideas"
alias trash="cd ~/trash"
alias vp="cd ~/apprentice-work"


alias vv="cd ~/.config/nvim && nvim init.lua"
alias vf="cd ~/.config/fish && nvim config.fish"
alias vh="cd ~/.config/hypr && nvim"
alias va="cd ~/.config/alacritty && nvim alacritty.toml "
alias vt="nvim ~/.tmux.conf"

alias ginit="git init && touch .gitignore && git status"
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias remote="git remote"
alias log="git log"
alias cb="git checkout -b"

function fish_prompt
    echo -n "  "

    set parent_dir (basename (dirname $PWD))
    set current_dir (basename $PWD)

    # Path
    set_color blue
    echo -n "$parent_dir::$current_dir"

    # Git branch
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set branch (git branch --show-current 2>/dev/null)

        if test -n "$branch"
            if test -n "$(git status --porcelain 2>/dev/null)"
                set_color red
            else
                set_color brblack
            end

            echo -n " ($branch)"
        end
    end

    # Separator
    set_color brblack
    echo -n " | "

    set_color normal
end

function brancher
	set target (git branch | sed 's/ //g' | sed 's/*//g' | fzf --style "full" --header "Git Brancher" --margin 10%)
	echo $target
	git checkout $target
end

function dir_finder
	set target (ls | fzf --style "full" --header "Directory Finder " --margin 10%)
	echo $target
	cd $target
end

bind \cg brancher
bind \cf dir_finder


# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3


function fish_prompt
	set_color brblack
	echo -n "["(date "+%H:%M")"] "
	set_color blue
	echo -n (command -q hostname; and hostname; or hostnamectl hostname)
	if [ $PWD != $HOME ]
		set_color brblack
		echo -n '::'
		set_color blue
		echo -n (basename $PWD)
	end
	set_color brblack
	printf '%s ' (__fish_git_prompt)
	set_color brblack
	echo -n '| '
	set_color normal
end


function fish_greeting
	echo
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uptime | sed 's/^.*up  *\([^,]*\),.*/\1/' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e " \\e[1mDisk usage:\\e[0m"
	echo
	echo -ne (\
		df -l -h | grep -E 'dev/(xvda|sd|mapper|nvme|disk)' | \
		awk '{printf "\\\\t%s\\\\t%4s / %4s  %s\\\\n\n", $6, $3, $2, $5}' | \
		sed -e 's/^\(.*\([8][5-9]\|[9][0-9]\)%.*\)$/\\\\e[0;31m\1\\\\e[0m/' -e 's/^\(.*\([7][5-9]\|[8][0-4]\)%.*\)$/\\\\e[0;33m\1\\\\e[0m/' | \
		paste -sd ''\
	)
	echo
	#
	# if command -q ip
	# 	echo -e " \\e[1mNetwork:\\e[0m"
	# 	echo
	# 	# http://tdt.rocks/linux_network_interface_naming.html
	# 	echo -ne (\
	# 		ip addr show up scope global | \
	# 			grep -E ': <|inet' | \
	# 			sed \
	# 				-e 's/^[[:digit:]]\+: //' \
	# 				-e 's/: <.*//' \
	# 				-e 's/.*inet[[:digit:]]* //' \
	# 				-e 's/\/.*//'| \
	# 			awk 'BEGIN {i=""} /\.|:/ {print i" "$0"\\\n"; next} // {i = $0}' | \
	# 			sort | \
	# 			column -t -R1 | \
	# 			# public addresses are underlined for visibility \
	# 			sed 's/ \([^ ]\+\)$/ \\\e[4m\1/' | \
	# 			# private addresses are not \
	# 			sed 's/m\(\(10\.\|172\.\(1[6-9]\|2[0-9]\|3[01]\)\|192\.168\.\).*\)/m\\\e[24m\1/' | \
	# 			# unknown interfaces are cyan \
	# 			sed 's/^\( *[^ ]\+\)/\\\e[36m\1/' | \
	# 			# ethernet interfaces are normal \
	# 			sed 's/\(\(en\|em\|eth\)[^ ]* .*\)/\\\e[39m\1/' | \
	# 			# wireless interfaces are purple \
	# 			sed 's/\(wl[^ ]* .*\)/\\\e[35m\1/' | \
	# 			# wwan interfaces are yellow \
	# 			sed 's/\(ww[^ ]* .*\).*/\\\e[33m\1/' | \
	# 			sed 's/$/\\\e[0m/' | \
	# 			sed 's/^/\t/' \
	# 		)
	# 	echo
	# end

	set r (random 0 100)
	if [ $r -lt 5 ] # only occasionally show backlog (5%)
		echo -e " \e[1mBacklog\e[0;32m"
		set_color blue
		echo "  [project] <description>"
		echo
	end

	set_color normal
	echo -e " \e[1mTODOs\e[0;32m"
	echo
	if [ $r -lt 10 ]
		# unimportant, so show rarely
		set_color cyan
		# echo "  [project] <description>"
	end
	if [ $r -lt 25 ]
		# back-of-my-mind, so show occasionally
		set_color green
		# echo "  [project] <description>"
	end
	if [ $r -lt 50 ]
		# upcoming, so prompt regularly
		set_color yellow
		# echo "  [project] <description>"
	end

	# urgent, so prompt always
	set_color red
	# echo "  [project] <description>"

	echo

	if test -s ~/todo
		set_color magenta
		cat todo | sed 's/^/ /'
		echo
	end

	set_color normal
end
