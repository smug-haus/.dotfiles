# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

function _platform() {
  if [ -n "${WSLENV}" ]; then
    HOST_PLATFORM=WSL
}

function _display() {
  
  if [ -n "${WSLENV}" ]; then
    # Are we in WSL?
    DISPLAY=${DISPLAY:-$(cat /etc/resolv.conf | grep name | cut -d' ' -f2):0.0}

  elif [ -n "$(cat /proc/1/sched | head -n 1 | grep -E '^(init|systemd)' )"]; then
    # do the socket thing
    true
  else
    DISPLAY=${DISPLAY:-0}
  fi

  echo $DISPLAY
}



# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export DISPLAY=$( _display )

export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock

if [ -x "$( ss -a | grep -q ${SSH_AUTH_SOCK} )"  ]; then
  rm -f $SSH_AUTH_SOCK
  ( setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:'/mnt/c/Program\\ Files/wsl-ssh-agent/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent',nofork & ) >/dev/null 2>&1
fi

