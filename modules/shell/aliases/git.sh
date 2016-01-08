
##################### 
### GIT 

## Super used ones

alias gc='git-cola'

alias gcp='git cherry-pick'

alias gs='git status -u'

alias gl=qgit-log-extended

alias qgit-stage="git add -i"

alias qgit-unstage="git reset HEAD -- "

alias qgit-create-tag-X-at-commit-Y="git tag -a"

alias qgit-log="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --name-status --full-history --abbrev-commit"

alias qgit-push='git push origin HEAD'

alias qgit-diff='git difftool'

# Git logs 

alias qgit-log-extended='git log --name-only --full-history'

alias qgit-commit-with-amend='git commit --amend'

alias qgit-commit-undo='git reset --soft HEAD^'

alias qgit-squeeze-from-commit-X='git rebase -i'

alias qgit-tree='git log --oneline --decorate --all --graph'

# Useful to rewrite a repository to delete passwords and sensitive information

alias qgit-bfg="java -jar $HOME/bin/zips/jars/bfg.jar"

alias qgit-push-all-even-tags='git push origin master --tags'

function qgit-bring-branch-from-repo-X-branch-Y(){
  REPO=$1
  BRANCH=$2
  git fetch $REPO $BRANCH:$BRANCH
}
