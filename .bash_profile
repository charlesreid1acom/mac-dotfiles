# This is the bash profile.
#
# This file sets PATH and bash options.
#
# to add your own non-committed machine-specific settings,
# use ~/.extra

# Must
EDITOR="vim"
GIT_EDITOR="vim"

# Better man pages
PAGER="most"

# Set $PATH here
PATH="${HOME}/scripts:${PATH}"

# set up gpg
export GPG_TTY=$(tty)

# Tell git not to look for getext.sh
# since pyenv has trouble with that
export GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=1


# brew
if [[ "$HOSTNAME" == "otto" ]]; then
    HOMEBREW_PATH="/opt/homebrew"
else
    HOMEBREW_PATH="/usr/local"
fi

# git tab completion
test -f ${HOME}/.git-completion.bash && source ${HOME}/.git-completion.bash

export PATH="${HOMEBREW_PATH}/bin:${PATH}"
export PATH="${HOMEBREW_PATH}/sbin:${PATH}" # homebrew admin tools
export PATH="${HOMEBREW_PATH}/opt/coreutils/libexec/gnubin:${PATH}"
PATH="${HOME}/bin:${PATH}"

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f ${HOMEBREW_PATH}/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;

elif type _git &> /dev/null && [ -f ${HOMEBREW_PATH}/etc/profile.d/bash_completion.sh ]; then
	complete -o default -o nospace -F _git g;

fi;

if [[ "$HOSTNAME" == "maya" ]]; then

    export PATH="${HOMEBREW_PATH}/opt/openjdk@11/bin:$PATH"

	# Setting PATH for homebrew
	PATH="$HOME/.local/bin:$PATH"
	PATH="$HOME/Library/Python/3.6/bin:$PATH"

    # pypy
    # this should go after /usr/local/bin
    PATH="${PATH}:${HOMEBREW_PATH}/share/pypy3"

    ### # some weird new homebrew thing??
    ### # this is where python -> python3 lives now
    ### # https://stackoverflow.com/a/45228901
    ### PATH="/usr/local/opt/python/libexec/bin:${PATH}"

	# Set up google cloud SDK
	F1="${HOMEBREW_PATH}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
	F2="${HOMEBREW_PATH}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
	if [[ -f $F1 ]]; then
		source $F1
	fi
	if [[ -f $F2 ]]; then
		source $F2
	fi
fi

# pyenv installer
# https://github.com/pyenv/pyenv-installer
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="/Users/creid/.pyenv/shims:${PATH}"


# Bash history

HISTFILE="$HOME/.bash_history"
HISTFILESIZE=1000000000
HISTIGNORE="ls:cls:clc:clear:pwd:l:ll:[ ]*"
HISTSIZE=1000000
HISTTIMEFORMAT=': %Y-%m-%d_%H:%M:%S; '

# Save Bash history
shopt -s cmdhist;
# Append to the Bash history file, rather than overwriting it
shopt -s histappend;
# Write history to .bash_history immediately.
# -a writes current/new lines to history file
# -n reloads only new commands
# https://askubuntu.com/a/673283
PROMPT_COMMAND='history -a;history -n'

# don't try to autocomplete commands when tab is pressed and line is empty
shopt -s no_empty_cmd_completion

#############################
# ssh-agent setup
### SSH_ENV="$HOME/.ssh/agent-environment"
### 
### function start_agent {
###     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
###     chmod 600 "${SSH_ENV}"
###     . "${SSH_ENV}" > /dev/null
###     /usr/bin/ssh-add;
### }
### 
### # Source SSH settings, if applicable
### if [ -f "${SSH_ENV}" ]; then
###     . "${SSH_ENV}" > /dev/null
###     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
###         start_agent;
###     }
### else
###     start_agent;
### fi


#############################
# modified mathias

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;
