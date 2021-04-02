# Undo some of the git aliases
unalias gm
unalias gap
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

onhold() {
	afplay ~/Downloads/Local-forecast-elevator-music/Elevator-music.mp3 & "$@"; pkill -o afplay; tput bel; say "Top. Floor"
}