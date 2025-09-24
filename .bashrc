alias nvim=$HOME/nvim-macos-arm64/bin/nvim
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


 export PATH=$PATH:~/.local/go/bin
 export PATH=$PATH:~/.local/bin

alias yogit=$HOME/yogit2/main

export TERM="xterm-256color"
export PATH="$HOME/.local/bin:$PATH"
# this makes sure that compilation is done with java17 instead of 21, This was mainly done 
# due to neovim lspserver as it relies on 21, but I want to run 17
# export JAVA_HOME=$(/usr/libexec/java_home -v 17)
# export PATH=$JAVA_HOME/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion






# ============= casa config for playwright
export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/zscaler.pem
export REQUEST_CA_BUNDLE=/etc/ssl/certs/ca-certs.pem


#to use c++17 compiler
alias g++="g++ -std=c++20"
