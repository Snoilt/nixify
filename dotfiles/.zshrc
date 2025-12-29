#!/usr/bin/env zsh
# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update 'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard 'mac'

# Start tmux if not already in tmux.
# zstyle ':z4h:' start-tmux command tmux -u new -A -D -t tmux

# Whether to move prompt to the bottom when zsh starts and on Ctrl+L.
zstyle ':z4h:' prompt-at-bottom 'no'

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'no'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv' enable 'yes'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
zstyle ':z4h:ssh:printcam' enable 'yes'
zstyle ':z4h:ssh:hserver' enable 'yes'

zstyle ':z4h:ssh:example-hostname1' enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*' enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
# z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
# z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin

# Easily prefix your current or previous commands with sudo by pressing esc twice.
z4h load ohmyzsh/ohmyzsh/plugins/sudo

# This plugin provides host completion based off of your ~/.ssh/config file,
# and adds some utility functions to work with SSH keys.
z4h load ohmyzsh/ohmyzsh/plugins/ssh
zstyle ':completion:*:ssh:*' users off

# Generate a QR Code from the command line. Uses QRcode.show via curl.
z4h load ohmyzsh/ohmyzsh/plugins/qrcode

# Define key bindings.
z4h bindkey undo Ctrl+/ Shift+Tab # undo the last command line change
z4h bindkey redo Option+/         # redo the last undone command line change

z4h bindkey z4h-cd-back Shift+Left     # cd into the previous directory
z4h bindkey z4h-cd-forward Shift+Right # cd into the next directory
z4h bindkey z4h-cd-up Shift+Up         # cd into the parent directory
z4h bindkey z4h-cd-down Shift+Down     # cd into a child directory

# Autoload functions.
autoload -Uz zmv

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# --------------------------------------------------------------------------------------
# aliases

alias ll='ls -lhFG' # list files but better
alias la='ll -A'    # list *all* files but better

# alias publicip='curl -4 -s ifconfig.co'
# alias localip='ipconfig getifaddr en0'
# alias scannet='ifconfig | grep broadcast | arp -a'

# export VISUAL='code -w'
# export EDITOR='code -w'

# # --------------------------------------------------------------------------------------
# # functions

# # creates a new directory and enters it
# md() {
# 	[[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1"
# }
# compdef _directories md

# # unquarantine files
# quaran() {
# 	xattr -d com.apple.quarantine "$1"
# }

# sync_conflict() {
# 	find . -name "*.sync-conflict-*"
# 	find . -name "*.sync-conflict-*" -type f -delete
# }

# whatport() {
# 	sudo lsof -n -i4TCP:$1 | grep LISTEN
# }

# killport() {
# 	port=$(lsof -n -i4TCP:$1 | grep LISTEN | awk '{ print $2 }')
# 	if [ -z "${port}" ]; then
# 		echo "No process found listening on port $1"
# 	else
# 		kill -9 $port
# 	fi
# }

# # tree defaulting to 2 levels
# t() {
# 	if [[ ! "$1" =~ ^[0-9]+$ ]]; then
# 		level=2
# 	else
# 		level="$1"
# 		shift
# 	fi

# 	tree -L "$level" "$@"
# }

# # --------------------------------------------------------------------------------------
# # software initializers

# # bun proper
# export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"
# [ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"

# # remove bun completions clean digga (auch bei symlink)
# tmpfile="$(mktemp)"
# awk '
#   $0 == "# bun completions" { skip=1; next }
#   skip { skip=0; next }
#   { print }
# ' "$HOME/.zshrc" >"$tmpfile" && mv "$tmpfile" "$HOME/.zshrc"

# # deno
# if [ -f "${HOME}/.deno/env" ]; then
# 	. "${HOME}/.deno/env"
# 	if [[ ":$FPATH:" != *":${HOME}/.zsh/completions:"* ]]; then export FPATH="${HOME}/.zsh/completions:$FPATH"; fi
# fi

# # go
# export GOPATH="$HOME/.go"
# export PATH="$GOPATH/bin:$PATH"

# # ruby
# if [ -d "/opt/homebrew/lib/ruby/gems/3.4.0/bin" ]; then
# 	PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"
# fi

# # Added by LM Studio CLI (lms)
# export PATH="$PATH:${HOME}/.cache/lm-studio/bin"

# # node fnm
# eval "$(fnm env --use-on-cd --shell zsh)"

# # zoxide
# eval "$(zoxide init zsh --cmd cd)"

# # task
# eval "$(task --completion zsh)"

# # --------------------------------------------------------------------------------------

# if [[ "${TERM_PROGRAM}" == "vscode" ]]; then
# 	if [[ "${PWD}" == "${HOME}" ]]; then
# 		cd "${HOME}/projects"
# 	fi
# fi

# # Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
# setopt glob_dots    # no special treatment for file names with a leading dot
# setopt no_auto_menu # require an extra TAB press to open the completion menu
