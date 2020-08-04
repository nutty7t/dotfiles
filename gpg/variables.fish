# The curses-based pinentry does not work without setting this variable.
# https://www.gnupg.org/(it)/documentation/manuals/gnupg/Common-Problems.html
set --export GPG_TTY (tty)

# Authorize SSH with GPG key.
set keygrip BDA0F0D14EC318874C7872020155BE3371806A42
cat ~/.gnupg/sshcontrol | grep $keygrip > /dev/null; or echo $keygrip >> ~/.gnupg/sshcontrol
pgrep ssh-agent > /dev/null; or eval (ssh-agent -c)
