if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red
    set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal $suffix " "
end

bind \t complete
bind \e\e accept-autosuggestion

alias gs="git status"
alias vim="nvim"
alias ga="git add ."
alias vv="nvim ~/.config/nvim"
alias vf="nvim ~/.config/fish"
alias dev="cd ~/dev"
alias src="source ~/.config/fish/config.fish && echo 'Do you know who else says ugh? ' "
alias ndev="npm run dev"
alias log="git log "
alias build="./build.sh"
alias trash="cd ~/trash"

function mc
	mkdir $argv[1] && cd $argv[1]
end

function defg
	set repo_name $argv[1]
	git init
	and git add .
	and git status
	and git remote origin add https://github.com/persona-mp3/$repo_name
end

function gc
	set msg $argv[1]
	git commit -m "$msg"
end 

function checkout
	git checkout -b $argv[1]
end


function fish_prompt
    # set user (whoami)
    set current (basename (pwd))
    set parent (basename (dirname (pwd)))


    # fallback for root
    if test "$parent" = ""
        set parent "/"
    end


    set_color brblue
    echo -n "  $parent"

    set_color brblue
    echo -n "::"

    set_color brblue
    echo -n $current

		
    # --- GIT BRANCH ---

		 if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set branch (git branch --show-current)

        git diff --quiet --ignore-submodules HEAD
        set dirty_status $status

        set untracked (git ls-files --others --exclude-standard)

        if test $dirty_status -ne 0 -o -n "$untracked"
            # DIRTY → red
            set_color red
        else
            # CLEAN → grey
            set_color brblack
        end

        echo -n " ($branch)"
			end
    # ------------------


    set_color normal
    echo -n " | "


end

function brancher
    set tgt_branch (git branch --format='%(refname:short)' \
        | fzf --margin=10% --layout=reverse --border -- \
              --preview 'git log --oneline --decorate --color=always {} | head -20' \
							--preview-window=down:99%
							)

    if test -z "$tgt_branch"
        return
    end

    git checkout $tgt_branch
end
alias br=brancher



function mvn_init 
	 mvn archetype:generate \
				 -DgroupId="$argv[1]" \
				 -DartifactId="$argv[2]" \
				 -DarchetypeArtifactId=maven-archetype-quickstart \
				 -DarchetypeVersion=1.5 \
				 -DinteractiveMode=false
end


set -x SDKMAN_DIR "$HOME/.sdkman"
if test -s "$HOME/.sdkman/bin/sdkman-init.sh"
    bass source "$HOME/.sdkman/bin/sdkman-init.sh"
end
