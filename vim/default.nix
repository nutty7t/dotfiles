{ symlinkJoin, makeWrapper, neovim, nodejs-14_x, vimPlugins }:
  let
    # Plugins that are automatically loaded when neovim launches
    autoloadedPlugins = with vimPlugins;
      [
        coc-nvim
        coc-pairs
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
    manualPlugins = with vimPlugins;
      [
        coc-css
        coc-emmet
        coc-eslint
        coc-html
        coc-jest
        coc-json
        coc-prettier
        coc-tslint
        coc-tslint-plugin
        coc-tsserver
        coc-yaml
      ];

    nuttyVim = neovim.override {
      configure = {
        customRC = ''
          source ${./config/align.vim}
          source ${./config/completion.vim}
          source ${./config/filetype.vim}
          source ${./config/fuzzy.vim}
          source ${./config/general.vim}
          source ${./config/gui.vim}
          source ${./config/keyboard.vim}
          source ${./config/whitespace.vim}
        '';

        packages.neovim = {
          start = autoloadedPlugins;
          opt = manualPlugins;
        };
      };

      vimAlias = true;
      viAlias = true;
      withNodeJs = true;
    };

  in
    symlinkJoin {
      name = "vim";
      buildInputs = [ makeWrapper ];
      paths = [ nuttyVim ];
    }
