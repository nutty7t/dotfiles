# The curses-based pinentry does not work without setting this variable.
# https://www.gnupg.org/(it)/documentation/manuals/gnupg/Common-Problems.html
set --export GPG_TTY (tty)

# Authorize SSH with GPG key.
set keygrip 2488D6BC80912B868503FADA03341331CAE89FA7
cat ~/.gnupg/sshcontrol | grep $keygrip >/dev/null; or echo $keygrip >>~/.gnupg/sshcontrol

pgrep ssh-agent >/dev/null; or eval (ssh-agent -c)
gpgconf --launch gpg-agent
