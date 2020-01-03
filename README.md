# dot • files

![neofetch](https://user-images.githubusercontent.com/40926021/71704201-1cd09f00-2d96-11ea-8c0d-9f0e8821a64f.png)

## Windows

> Wow! Windows Subsystem for Linux (WSL) is actually good! Finally, I can get
> the best of both worlds now: a *nix environment (I mean, there was Cygwin,
> but that's an uncanny valley) *and* the ability to run PC games and Adobe
> Creative Cloud programs.

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

curl https://nixos.org/nix/install | sh

```
3. Install dotfiles.

``` bash
git clone https://github.com/nutty7t/dotfiles ~/.dotfiles
cd ~/.dotfiles
nix-shell --run "zsh ./setup.sh"
```

4. Setup Z-Shell.

``` bash
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)
```

## Docker

> My dotfiles can be built as a Docker container, which means that you can try
> them out in a sandboxed environment without messing up your own system. It
> also means that it's easy to deploy my development environment [in the cloud]
> so that it's accessible anywhere I go!

1. Clone the repository.

``` bash
git clone https://github.com/nutty7t/dotfiles
cd dotfiles
```

2. Build the image.

``` bash
nix-shell # optional
docker build --no-cache --tag nutty7t/dotfiles .
```

Alternatively, the image can be pulled from [Docker Hub] -- but who knows
if it's up-to-date.

``` bash
docker pull nutty7t/dotfiles:latest
```

3. Run the container.

``` bash
docker run --hostname nuttydots -it nutty7t/dotfiles zsh
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
