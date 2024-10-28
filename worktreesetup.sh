#!/usr/bin/env bash
set -e

# Examples of call:
# git-clone-bare-for-worktrees git@github.com:name/repo.git
# => Clones to a /repo directory
#
# git-clone-bare-for-worktrees git@github.com:name/repo.git my-repo
# => Clones to a /my-repo directory

url=$1
basename=${url##*/}
name=${2:-${basename%.*}}

mkdir "$name"
cd "$name"

# Moves all the administrative git files (a.k.a $GIT_DIR) under .bare directory.
#
# Plan is to create worktrees as siblings of this directory.
# Example targeted structure:
# .bare
# main
# new-awesome-feature
# hotfix-bug-12
# ...
git clone --bare "$url" .bare
echo "gitdir: ./.bare" > .git

# Explicitly sets the remote origin fetch so we can fetch remote branches
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Fetches all branches from origin
git fetch origin

# Loop through all remote branches and set upstream for local branches
for remote_branch in $(git branch -r | grep 'origin/'); do
  # Strip 'origin/' prefix to get the branch name
  branch_name=${remote_branch#origin/}

  # Check if local branch exists; if not, create it
  if ! git show-ref --quiet refs/heads/"$branch_name"; then
    echo "Creating local branch $branch_name from remote $remote_branch"
    git checkout -b "$branch_name" "$remote_branch"
  fi

  # Set upstream for the local branch
  echo "Setting upstream for branch $branch_name"
  git branch --set-upstream-to="$remote_branch" "$branch_name"
done
