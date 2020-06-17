{ fetchFromGitHub, lib, symlinkJoin, makeWrapper
, neovim
, nodejs-12_x
, nodePackages
, vimPlugins
, vimUtils
}:
  let
    customPlugins = {
      purescript-vim = vimUtils.buildVimPlugin {
        name = "purescript-vim";
        src = fetchFromGitHub {
          owner = "purescript-contrib";
          repo = "purescript-vim";
          rev = "67ca4dc4a0291e5d8c8da48bffc0f3d2c9739e7f";
          sha256 = "1insh39hzbynr6qxb215qxhpifl5m8i5i0d09a3b6v679i7s11i8";
        };
      };
    };

    # Plugins that are automatically loaded when neovim launches
    autoloadedPlugins = with vimPlugins // customPlugins;
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
    manualPlugins = with vimPlugins // customPlugins;
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
        purescript-vim
      ];

    node2nixPackages = import ./packages {};
    binPath = with nodePackages;
      lib.strings.makeBinPath [
        "${nodejs-12_x}"
        "${bash-language-server}"
        "${dockerfile-language-server-nodejs}"
        "${node2nixPackages."purescript-language-server-0.12.9"}"
      ];

    nuttyVim = neovim.override {
      configure = {
        customRC = ''
          " must be loaded first
          source ${./config/general.vim}
          source ${./config/align.vim}
          source ${./config/completion.vim}
          source ${./config/filetype.vim}
          source ${./config/fuzzy.vim}
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
    };

  in
    symlinkJoin {
      name = "vim";
      buildInputs = [ makeWrapper ];
      paths = [ nuttyVim ];
      postBuild = ''
        wrapProgram "$out/bin/nvim" \
          --suffix PATH : ${binPath}
      '';
    }
