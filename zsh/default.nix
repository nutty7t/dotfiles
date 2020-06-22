{ symlinkJoin, makeWrapper, dotfiles, zsh }:
  symlinkJoin {
    name = "zsh";
    paths = [ zsh ];
    buildInputs = [ makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/zsh" \
        --set ZDOTDIR ${dotfiles}/share/dotfiles
    '';
  }
