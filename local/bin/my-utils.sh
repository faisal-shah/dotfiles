# Gets the download url for the latest release of a package provided via GitHub Releases
# Usage: ghrelease USER REPO [PATTERN]
ghrelease() {
	curl -s "https://api.github.com/repos/$1/$2/releases/latest" | grep -o "http.*${3:-deb}"
}

# Installs a local or remote(http/https) deb package and removes it after installation
installdeb() {
	set -e
	loc="./install.deb"
	case $1 in
	http*) wget -O "$loc" $1;;
	*) loc="$1"
	esac
	sudo dpkg -i "$loc"
	sudo apt -f install
	sudo rm -f "$loc"
}

git-diff-files-from-branches () {
    is_in_git_repo || return
    local b1 b2 f1 f2
    printf "\nEnter first branch: "
    b1=$(gb)
    printf "$b1\n"
    printf "Enter first file: "
    f1=$(git ls-tree --name-only -r $b1 |
        fzf --height 50% --border --preview-window right:70% --layout reverse \
        --preview 'bat --style=numbers --color=always --line-range :500 {}')
    printf "$f1\n"
    printf "Enter second branch: "
    b2=$(gb)
    printf "$b2\n"
    printf "Enter second file: "
    f2=$(git ls-tree --name-only -r $b2 |
        fzf --height 50% --border --preview-window right:70% --layout reverse \
        --preview 'bat --style=numbers --color=always --line-range :500 {}')
    printf "$f2\n"
    echo "git difftool -y $b1:$f1 $b2:$f2"
    git difftool -y $b1:$f1 $b2:$f2
}
