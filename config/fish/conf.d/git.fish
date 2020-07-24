# Git aliases

#compdef _git gst=git-status
alias gst='git status'
#compdef _git gd=git-diff
alias gd='git diff'
#compdef _git gdc=git-diff
alias gdc='git diff --cached'
#compdef _git gl=git-pull
alias gl='git pull'
#compdef _git gup=git-fetch
alias gup='git pull --rebase'
#compdef _git gp=git-push
alias gp='git push'
alias gd='git diff'

#compdef _git gc=git-commit
alias gc='git commit -v'
#compdef _git gc!=git-commit
alias gc!='git commit -v --amend'
#compdef _git gc=git-commit
alias gca='git commit -v -a'
#compdef _git gca!=git-commit
alias gca!='git commit -v -a --amend'
#compdef _git gcmsg=git-commit
alias gcmsg='git commit -m'
#compdef _git gco=git-checkout
alias gco='git checkout'
alias gcm='git checkout master'
#compdef _git gr=git-remote
alias gr='git remote'
#compdef _git grv=git-remote
alias grv='git remote -v'
#compdef _git grmv=git-remote
alias grmv='git remote rename'
#compdef _git grrm=git-remote
alias grrm='git remote remove'
#compdef _git grset=git-remote
alias grset='git remote set-url'
#compdef _git grset=git-remote
alias grup='git remote update'
#compdef _git grbi=git-rebase
alias grbi='git rebase -i'
#compdef _git grbc=git-rebase
alias grbc='git rebase --continue'
#compdef _git grba=git-rebase
alias grba='git rebase --abort'
#compdef _git gb=git-branch
alias gb='git branch'
#compdef _git gba=git-branch
alias gba='git branch -a'
#compdef gcount=git
alias gcount='git shortlog -sn'
alias gcl='git config --list'
#compdef _git gcp=git-cherry-pick
alias gcp='git cherry-pick'
#compdef _git glg=git-log
alias glg='git log --stat --max-count=10'
#compdef _git glgg=git-log
alias glgg='git log --graph --max-count=10'
#compdef _git glgga=git-log
alias glgga='git log --graph --decorate --all'
#compdef _git glo=git-log
alias glo='git log --oneline'
#compdef _git gss=git-status
alias gss='git status -s'
#compdef _git ga=git-add
alias ga='git add'
#compdef _git gm=git-merge
alias gm='git merge'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gclean='git reset --hard; and git clean -dfx'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'

alias gpoat='git push origin --all; and git push origin --tags'
#compdef _git gm=git-mergetool
alias gmt='git mergetool --no-prompt'

alias gss='git stash show --text'
alias gsa='git stash'
alias gsp='git stash pop'
alias gsd='git stash drop'
