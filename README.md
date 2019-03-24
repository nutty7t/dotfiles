# dotfiles (Raspberry Pi)

> A quick, hacked-together port of my dotfiles in `master` that works on the
> Raspberry Pi 3 Model B. It installs the essential things that makes the
> terminal usable.  There is probably a bunch of stuff that is broken. I
> discovered that there's some stuff that works on `x86` that doesn't work on
> `ARM` (such as `exa`).

1. Install [Arch Linux ARM](https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3).

2. Connect to WiFi (`wifi-menu` provides a TUI).

3. Clone this repository.

4. Checkout the `raspberry` branch.

5. Run `./root_install.sh` as root.

6. Run `./user_install.sh` as nutty.

