# Undo some of the git aliases
unalias gm
unalias gap
unalias gup
alias gap="git add -p"

# Some git helpers

# Go forward in Git commit hierarchy, towards particular commit
# Usage:
#  gofwd v1.2.7
# Does nothing when the parameter is not specified.
gofwd() {
	git checkout $(git rev-list --topo-order HEAD.."$*" | tail -1)
}

# Go back in Git commit hierarchy
# Usage:
#  goback
alias goback='git checkout HEAD~'

gch() {
	if [[ $1 -eq "-h" ]]; then
		echo "Checkout a base branch and pull the latest changes and branch from it."
		echo "Example: gch GH1234"
		echo "		   gch main GH1234"
		return;
	fi

	if [[ $# -eq 1 ]]; then
		configDefaultBranch=`git config --get init.defaultBranch`
		defaultBranch=${configDefaultBranch:-master}
		configbase=`git config --get gch.branching-base`
		base=${configbase:-$defaultBranch}
		branch=$1
	elif [[ $# -eq 2 ]]; then
		base=$1
		branch=$2
	else
		echo "Illegal number of arguments passed."
		return;
	fi
	git checkout $base && git pull origin $base && git checkout -b $branch
}

gup() {
	if [[ -n $1 ]] && [[ $1 -eq "-h" ]]; then
		echo "Push up the current branch to the origin remote."
		echo "Example: gup"
		echo "		   gup --force"
		return;
	fi
	
	currentBranch=`git rev-parse --abbrev-ref HEAD`
	git push --set-upstream origin $currentBranch "$@"
}

gcpf() {
	if [[ $1 -eq "-h" ]]; then
		echo "Cherry pick a file from another branch."
		echo "Example: gcpf another-branch ./src/Views/App.vue"
		return;
	fi
	
	git checkout $1 -- $2
}

gbn() {
	if [[ $1 -eq "-h" ]]; then
		echo "Creates a bundle for the current repo."
		echo "Example: gbn"
		return;
	fi
	
	currentRoot=`git rev-parse --show-toplevel`
	currentRepo=`basename $currentRoot`
	git bundle create "$currentRepo.bundle" --all
}

# Misc

onhold() {
	afplay ~/Downloads/Local-forecast-elevator-music/Elevator-music.mp3 & "$@"; pkill -o afplay; tput bel; say "Top. Floor"
}