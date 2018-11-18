# dotfiles

If installing tmux from source, may need to modify get_tmux_version() in
~/.local/lib/python3.6/site-packages/powerline/bindings/tmux/__init__.py. For
some reason, next-2.9 or whatever the version reports for the lastest from
github messes with tmux and powerline doesn't show up.

Need to change the colors of the terminal to solarized dark.

Need to modify ~/.local/lib/python3.6/site-packages/powerline/config_files/config.json
so that shell["theme"] is "default_leftonly", or else git status
information won't shuw up in bash. More advanced shells like zsh or fish allow
for a left and a right side ...

Restart powerline daemone with: powerline-deamon --replace
