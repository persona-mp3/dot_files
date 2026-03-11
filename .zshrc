export ZSH="$HOME/.oh-my-zsh"
# for f in ~/config-files/*.sh; do source "$f"; done

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
#
# plugins=(git)

# source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/opt/homebrew/bin:$PATH"
PS1=' %2~ -> '
# PS1=' -> '
traverse_dir(){
	target_dir=$(ls | fzf --height=80% --margin=20% --border | xargs)
	if [[ -z $target_dir ]]; then
		return
	fi
	cd $target_dir && ls
}

alias vim="nvim"
alias gs="git status"
alias ga="git add ."
alias src="source ~/.zshrc"
alias vz="vim ~/.zshrc"
alias vv="vim ~/.config/nvim"


alias dev="npm run dev"
alias log="git log"$1


mc(){ mkdir $1 && cd $1}

traverse_dir(){
	target_dir=$(ls | fzf --height=80% --margin=20% --border | xargs)
	if [[ -z $target_dir ]]; then
		return
	fi
	cd $target_dir && pwd && ls
}


alias proj="cd ~/projects && traverse_dir"
alias kata="cd ~/challenges && traverse_dir"
alias tuts="cd ~/tuts && traverse_dir"
alias refacts="cd ~/refactors && traverse_dir"
alias katas="cd ~/katas && traverse_dir"

brancher(){
	tgt_branch=$(git branch | sed 's/* //' | fzf --height=40% --margin=20% --border | xargs)

	if [[ -z $tgt_branch ]]; then
		return
	fi

	cmd=$(git checkout $tgt_branch)
	return
}

alias nv="make_env"
make_env(){
	python3 -m venv _env && pwd && ls 
	source ./_env/bin/activate
	pip install pytest
	echo "_env" >> .gitignore
	echo "__pycache___" >> .gitignore
}
alias snv="source ./_env/bin/activate"
#
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
 export NVM_DIR=/Users/MakersAdmin/.nvm
  [ -s /opt/homebrew/opt/nvm/nvm.sh ] && \. /opt/homebrew/opt/nvm/nvm.sh  # This loads nvm
  [ -s /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm ] && \. /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm  # This loads nvm bash_completion




export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)" 

# pSQL§
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# custom executables
export PATH="$PATH:$HOME/projects/koko/builds"


function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/*\1/p'
}

COLOR_DEF=$'%f'
COLOR_DIR=$'%F{260}'
COLOR_GIT=$'%F{245}'
COLOR_PIPE=$'%F{9}'
setopt PROMPT_SUBST
export PROMPT=' ${COLOR_DIR}%2~ ${COLOR_GIT}$(parse_git_branch)${COLOR_PIPE} |${COLOR_DEF} '

# . "$HOME/.local/bin/env"
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
# export PKG_CONFIG_PATH="$(brew --prefix)/lib/pkgconfig:$(brew --prefix)/opt/zlib/lib/
# pkgconfig:$(brew --prefix)/opt/libpng/lib/pkgconfig:$(brew --prefix)/opt/freetype/lib/pkgconfig"
# uv add manim

export PKG_CONFIG_PATH="$(brew --prefix)/opt/bzip2/lib/pkgconfig:$(brew --prefix)/opt/expat/lib/pkgconfig:$(brew --prefix)/opt/zlib/lib/pkgconfig:$(brew --prefix)/lib/pkgconfig"
