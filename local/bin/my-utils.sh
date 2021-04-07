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
