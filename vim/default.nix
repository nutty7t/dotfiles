{ symlinkJoin, makeWrapper, neovim, vimPlugins }:
  let
    # Plugins that are automatically loaded when neovim launches
    autoloadedPlugins = with vimPlugins;
      [
        easy-align
        editorconfig-vim
        fzf-vim
        surround
        tcomment_vim
        tmux-navigator
        vim-better-whitespace
        vim-dirvish
      ];

    # Plugins that are manually loaded by calling `:packadd <plugin>`
    manualPlugins = with vimPlugins; [];

    nuttyVim = neovim.override {
      configure = {
        customRC = ''
          " must be loaded first
          source ${./config/general.vim}
          source ${./config/align.vim}
          source ${./config/fuzzy.vim}
          source ${./config/gui.vim}
          source ${./config/whitespace.vim}
        '';

        packages.neovim = {
          start = autoloadedPlugins;
          opt = manualPlugins;
        };
      };

      vimAlias = true;
      viAlias = true;
    };

  in
    symlinkJoin {
      name = "vim";
      buildInputs = [ makeWrapper ];
      paths = [ nuttyVim ];
    }
