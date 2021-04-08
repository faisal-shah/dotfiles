# dotfiles
The core:
* vim
* git
* tmux
* fzf
* ripgrep

Other:
* powerline (bling bling!)
* GruvBox theme for Konsole
* bat (pretty cat replacement)
* delta (pretty diff replacement)
* keybinds, navigation and git helpers (forgit among others...)

Install environment with:
```
$./installenv.sh
```

The script is totally not idempotent. It will keep appending to your .bashrc each time you run the thing. Also, doesn't clean up particularly well. Thankfully, it uses apt and gdebi to install most of the packages - which are (I think) idempotent in nature.

Bunch of packages from standard Ubuntu package repos (Need 20.10+ for latest ripgrep version ... required for bat-extras).

Vim and Git PPAs are used to get the latest versions of them.

Some programs installed from github - again for the latest versions.
