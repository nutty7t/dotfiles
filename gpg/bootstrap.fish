# The curses-based pinentry does not work without setting this variable.
# https://www.gnupg.org/(it)/documentation/manuals/gnupg/Common-Problems.html
set --export GPG_TTY (tty)

# Authorize SSH with GPG key.
set keygrip 2488D6BC80912B868503FADA03341331CAE89FA7
cat ~/.gnupg/sshcontrol | grep $keygrip >/dev/null; or echo $keygrip >>~/.gnupg/sshcontrol

# Launch gpg-agent if it's not already running.
pgrep gpg-agent >/dev/null; or gpgconf --launch gpg-agent >/dev/null

# Change the standard display so that pinentry works. Not sure why this works.
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=835394
gpg-connect-agent updatestartuptty /bye >/dev/null