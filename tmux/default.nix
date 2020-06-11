{ makeWrapper, symlinkJoin, tmux, tmuxPlugins }:
  let
    plugins = with tmuxPlugins;
      [
        vim-tmux-navigator
      ];
  in
    symlinkJoin {
      name = "tmux";
      buildInputs = [ makeWrapper ];
      paths = [ tmux ];
      postBuild = ''
        wrapProgram "$out/bin/tmux" \
          --add-flags "-f ${./tmux.conf}" \
          --add-flags "-u"
      '';
    }
