let
  pkgs = import <nixpkgs> {};

  cpkgs = rec {
    dotfiles = pkgs.callPackage ./dotfiles.nix {};
    tmux = pkgs.callPackage ./tmux {};
    vim = pkgs.callPackage ./vim {};
    zsh = pkgs.callPackage ./zsh { dotfiles = dotfiles; };
  };

  packagesToInstall =
    [
      # ⚫
      cpkgs.dotfiles

      # Utilities
      pkgs.bat
      pkgs.coreutils
      pkgs.curl
      pkgs.exa
      pkgs.fselect
      pkgs.fzf
      pkgs.gnugrep
      pkgs.gnused
      pkgs.httpie
      pkgs.less
      pkgs.man-db
      pkgs.man-pages
      pkgs.openssh
      pkgs.ripgrep

      # Cloud Tools
      pkgs.docker
      pkgs.kubectl

      # Git
      pkgs.gitAndTools.gitFull
      pkgs.gitAndTools.diff-so-fancy
      pkgs.gitAndTools.tig

      # Workhorses
      cpkgs.tmux
      cpkgs.vim
      pkgs.emacs
      pkgs.kakoune

      # Shells
      cpkgs.zsh
      pkgs.bash
      pkgs.fish

      # Zsh Plugins
      pkgs.nix-zsh-completions
      pkgs.spaceship-prompt
      pkgs.zsh-autosuggestions
      pkgs.zsh-nix-shell
      pkgs.zsh-syntax-highlighting
    ];

in
  if pkgs.lib.inNixShell
  then pkgs.mkShell {
    buildInputs = packagesToInstall;
    shellHook = ''
      $(zsh)
    '';
  }
  else packagesToInstall
