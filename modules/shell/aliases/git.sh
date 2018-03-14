
##################### 
### GIT 

## Super used ones

# Launches the fantastic git-cola to perform a tidy commit
function gc(){
  echo ""
  echo ""
  echo "Last commits: "
  git --no-pager log --reverse -30 --pretty=%s
  echo ""
  echo ""
  git-cola 
}

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

alias qgit-squeeze-from-30-ago='git rebase -i HEAD~30'

alias qgit-tree='git log --oneline --decorate --all --graph'

# Useful to rewrite a repository to delete passwords and sensitive information

alias qgit-bfg="java -jar $HOME/bin/zips/jars/bfg.jar"

alias qgit-tag-push-master='git push origin master --tags'

alias qgit-tag-push='git push --tags'

alias qgit-tag-delete='git tag --delete'

alias qgit-tag-delete-remote='git push --delete origin'

function qgit-tag-fast(){
  git tag "$1" -m "$1"
}

# Copy bring remote branch to local repo
function qgit-bring-branch-from-repo-X-branch-Y(){
  REPO=$1
  BRANCH=$2
  git fetch $REPO $BRANCH:$BRANCH
}

# Remember https credentials for 10 hours (remote via https & secured)
function qgit-remember-https-credentials(){
  git config --global credential.helper cache
  git config --global credential.helper 'cache --timeout=36000'
}

alias qgit-delete-branch-X='git push origin --delete'

alias qgit-list-remote-branches-in-X="git ls-remote --heads"

# Put staged changes somewhere in an existent commit via fixup
function qgit-fixup-staged-changes-in-commit-X() {
  local commit="$1"
  echo "Staged changes already???"
  echo "Commit $commit is correct?"
  git log | grep $commit
  sleep 2
  echo "If OK, save and exit."
  sleep 3
  git commit -s -m "fixup! $commit"
  git rebase $commit^ -i --autosquash
  git log | grep $commit
  echo "Done"
}

