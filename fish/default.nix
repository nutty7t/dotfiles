{ config, pkgs, ... }:
  {
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      defaultCommand = "${pkgs.ripgrep}/bin/rg --files --hidden --glob \"!.git\"";
      defaultOptions = [ "--multi" "--preview '${pkgs.bat}/bin/bat --color \"always\" {}'" ];
    };

    programs.bash = {
      enable = true;
    };

    programs.fish = {
      enable = true;

      plugins = [
        {
          name = "plugin-foreign-env";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-foreign-env";
            rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
            sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
          };
        }
        {
          name = "fish-kubectl-completions";
          src = pkgs.fetchFromGitHub {
            owner = "evanlucas";
            repo = "fish-kubectl-completions";
            rev = "7bea3e12ff2147961e808b9308b79828aa17b222";
            sha256 = "1mikic0314619bkgan5pjg74xri9x2m3gq16n5f4bicqfbsb7kkc";
          };
        }
      ];

      shellAbbrs = {
        ls = "exa --group-directories-first";
        la = "exa --group-directories-first --all";
        ll = "exa --group-directories-first --long";
        lt = "exa --group-directories-first --tree";
        llt = "exa --group-directories-first --long --tree";

        c = "clear";
        cat = "bat";
        ln = "ln --symbolic";
        cp = "cp --interactive --verbose";
        mv = "mv --interactive --verbose";
        mkdir = "mkdir --parents --verbose";

        g = "git";
        ga = "git add";
        gc = "git commit --verbose";
        "gc!" = "git commit --verbose --amend";
        gp = "git push";
        gco = "git checkout";
        gst = "git status";
        glog = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";

        d = "docker";
        do = "doctl";
        h = "helm";
        k = "kubectl";
        t = "tmux";
        xp = "explorer.exe .";
        vimf = "vim (fzf)";
        dotfiles = "cd ~/Code/dotfiles";
      };

      shellInit = builtins.concatStringsSep "\n" ([
        ''
          # If we're not in NixOS, then start up a Nix environment.
          if not grep --ignore-case "nixos" /proc/version &> /dev/null
            fenv source ~/.nix-profile/etc/profile.d/nix.sh 2> /dev/null
          end

          # Set home manager session variables.
          fenv source ~/.nix-profile/etc/profile.d/hm-session-vars.sh

          # $TMUX_TMPDIR gets set by home manager, but it seems to break tmux.
          # Might be related to https://github.com/rycee/home-manager/issues/1270.
          set --erase TMUX_TMPDIR
        ''
      ] ++ map builtins.readFile [
        ../emacs/hack.fish
        ../fish/greeting.fish
        ../fish/prompt.fish
        ../gpg/bootstrap.fish
        ../x11/windows.fish
      ]);
    };
  }
