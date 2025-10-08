# alias nvim=$HOME/nvim-macos-arm64/bin/nvim
PS1='\W -> '
name="Archive"
nline=$'\n'

#PS1="$name in \w $nline>> "

mc(){
	mkdir $1 && cd $1
}

casa(){
	cd $HOME/Desktop/projects/casa
}

casa2(){
	cd $HOME/casa2
}

casa3(){
	cd $HOME/casa3
}
projects(){
	cd $HOME/Desktop/projects
}

branch(){
	target=$(git branch | sed 's/* //' | fzf --height=40% --margin=20% --border)
	if [ $? -ne 0 ]; then
		echo "fzf exited with $?"
		return $?
	fi
	if [[ -z $target ]]; then
		echo "no branch selected"
		return $?
	fi

	cmd=$(git switch $target)
	return
}




export PATH=$PATH:~/.local/go/bin
export PATH=$PATH:~/.local/bin

alias yogit=$HOME/yogit2/main
alias ga="git add ."
alias gs="git status"
alias vim="nvim"
alias vv="nvim ~/.config/nvim"
alias vb="vim ~/.bashrc"

export TERM="xterm-256color"
export PATH="$HOME/.local/bin:$PATH"
# this makes sure that compilation is done with java17 instead of 21, This was mainly done 
# due to neovim lspserver as it relies on 21, but I want to run 17
# export JAVA_HOME=$(/usr/libexec/java_home -v 17)
# export PATH=$JAVA_HOME/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm use 21.1.0


# ============= casa config for playwright
export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/zscaler.pem
export REQUEST_CA_BUNDLE=/etc/ssl/certs/ca-certs.pem


#to use c++17 compiler
alias g++="g++ -std=c++20"


alias ff="fzf --style full --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'"
#alias ff="fzf --preview 'fzf-preview.sh {}' --height 90%  --border"
alias reload="source ~/.bashrc && clear"

export HOMEBREW_NO_AUTO_UPDATE=1



