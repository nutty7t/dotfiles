{ makeWrapper, symlinkJoin, tmux, tmuxPlugins }:
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
