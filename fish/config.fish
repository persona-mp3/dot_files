if status is-interactive
# Commands to run in interactive sessions can go here
end

alias vim=nvim
alias dev="cd ~/dev"
alias idea="cd ~/ideas"
alias src="source ~/.config/fish/config.fish" && echo " Do you know who else sources their config instead of working?"

alias vv="cd ~/.config/nvim && nvim"
alias vf="cd ~/.config/fish && nvim"
alias vh="cd ~/.config/hypr && nvim"

alias ginit="git init && touch .gitignore && git status"
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m "
alias remote="git remote -v"
alias log="git log"
