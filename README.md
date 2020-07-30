# dot • files

![neofetch](https://user-images.githubusercontent.com/40926021/71704201-1cd09f00-2d96-11ea-8c0d-9f0e8821a64f.png)

## Windows

> Windows Subsystem for Linux (WSL) makes the development experience on this
> operating system something worth ditching macOS for! I get the best of both
> worlds now: a *nix environment (I mean, there was Cygwin, but that's an
> uncanny valley) *and* the ability to run PC games and Adobe Creative Cloud
> programs.

1. Install [Windows Subsystem for Linux] (Debian).

2. Install [Nix] ❆.

``` bash
sudo apt update
sudo apt upgrade
sudo apt install curl xz-utils

# Workarounds -- https://nathan.gs/2019/04/12/nix-on-windows/
sudo mkdir -p /etc/nix
echo "sandbox = false"        | sudo tee    /etc/nix/nix.conf
echo "use-sqlite-wal = false" | sudo tee -a /etc/nix/nix.conf

curl -L https://nixos.org/nix/install | sh
. ~/.nix-profile/etc/profile.d/nix.sh

# Home Manager
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

3. Install dotfiles.

``` bash
mkdir --parents ~/Code
nix-shell -p git --run "git clone https://github.com/nutty7t/dotfiles ~/Code/dotfiles"
ln --symbolic --force ~/Code/dotfiles/dotfiles.nix ~/.config/nixpkgs/home.nix
nix-shell '<home-manager>' -A install
home-manager switch
```

4. Set `fish` as the default shell.

``` bash
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
```

5. Become evil? Join the dark side. 🖤

``` bash
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
```

## Docker

> My dotfiles can be built as a Docker container, which means that you can try
> them out in a sandboxed environment without messing up your own system. It
> also means that it's easy to deploy my development environment [in the cloud].

``` bash
# Download the image
docker pull nutty7t/dotfiles:latest

# OR build the image
git clone https://github.com/nutty7t/dotfiles && cd dotfiles
docker build --no-cache --tag nutty7t/dotfiles .

# AND start the container
docker run --hostname nuttydots -it nutty7t/dotfiles fish
```

## Troubleshooting

> Occassionally, I get random `Segmentation fault (core dumped)` or `unable to
> fork: Invalid argument` errors in Windows Subsystem for Linux. What's up?

Make sure that your system has a good amount of available RAM. You can
[click here to download RAM].

<!-- References -->
[Windows Subsystem for Linux]: https://docs.microsoft.com/en-us/windows/wsl/install-win10
[Nix]: https://nixos.org/nix/
[in the cloud]: https://github.com/nutty7t/cloud
[Docker Hub]: https://hub.docker.com/repository/docker/nutty7t/dotfiles
[click here to download RAM]: https://downloadmoreram.com/
