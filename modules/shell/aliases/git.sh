
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
  echo "If WSL: use VcXsrv with 'Native opengl' setting enabled"
  git-cola &> /dev/null
}

# current branch
function qgit-branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function qgit-branches() {
git branch --sort='-authordate'
}

function qgit-branch-delete-remote() {
  git push $1 --delete $2
}

function qgit-number-of-commits-until-this-one() {
  git rev-list HEAD --count
}

alias gcp='git cherry-pick'

alias gs='git status -u'

alias gl=qgit-log-extended

function qgit-history-for-file-x() {
  gitk --follow "$1"
}

alias qgit-stage="git add -i"

alias qgit-unstage="git reset HEAD -- "

alias qgit-create-tag-X-at-commit-Y="git tag -a"

alias qgit-log="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --name-status --full-history --abbrev-commit"

alias qgit-push='git push origin HEAD'

alias qgit-diff='git difftool'

alias qgit-untrack-tracked-file='git update-index --skip-worktree'

# Git logs 

alias qgit-log-extended='git log --name-only --full-history'

alias qgit-commit-with-amend='git commit --amend'

alias qgit-commit-undo='git reset --soft HEAD^'

alias qgit-rebase-interactive-from-commit-X='git rebase -i'

alias qgit-rebase-interactive-from-30-ago='git rebase -i HEAD~30'

alias qgit-tree='git log --oneline --decorate --all --graph'

# Useful to rewrite a repository to delete passwords and sensitive information

function qgit-remove-passowrds-bfg-from-repoX-in-file-Y() {
  local repo_mirrored_dir="$1"
  local pwd_file="$2"
  cd $repo_mirrored_dir
  echo "Create a clone repo with 'git clone --mirror xxxx' before proceeding"
  sleep 2
  java -jar $HOME/bin/zips/jars/bfg.jar -rt $pwd_file .
  git gc --prune=now --aggressive
  echo "Now take a look at the repo..."
  sleep 2
  echo "Then, if satisfied, do: 'git push'"
}

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

# Commits that were not integrated in master branch (to run before a branch removal to prevent work loss)
function qgit-missing-commits-in-x-not-present-in-master-y() {
  local merged_or_not="$1"
  local master="${2:-master}"
  echo "Commits in $merged_or_not not present in $master:"
  git log --no-merges "$merged_or_not" ^"$master"
}

function qgit-submodule-init-recursively() {
  git submodule update --init --recursive
}

function qgit-remove-submodule-x-path-y() {
  local submodule=$2
  local path_to_submodule=$2
  git submodule deinit $path_to_submodule
  git rm $path_to_submodule
  git commit-m "Removed submodule $submodule"
  rm -rf .git/modules/$path_to_submodule
}

function qgit-search-commit-such-that() {
  local branch="$1"
  local expr_condition="$2"
  local max_commits="${3:-50}"
  local expr_debug="${4:-echo boh}"
  local format='%h %aN %ci %s'
  local curr_branch="$(qgit-branch)"
  # qgit-search-commit-such-that 'master' '[ "$(cat kafka-consumer/version.txt)" == "1.1.70" ] && echo true ' 'echo hello'
  for commit in $(git rev-list "$branch" | head -$max_commits)
  do
	  git checkout "$commit" &> /dev/null
	  if [ "$(eval "$expr_condition")" == "true" ]
	  then
	    echo ">>>> $(git show -s --format="$format" "$commit" | cut -c1-120) $(eval "$expr_debug")"
	  else
	    echo "     $(git show -s --format="$format" "$commit" | cut -c1-120) $(eval "$expr_debug")"
	  fi
  done
  git checkout "${curr_branch}"
}
