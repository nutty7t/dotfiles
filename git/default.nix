{ symlinkJoin, makeWrapper, dotfiles, git }:
  symlinkJoin {
    name = "git";
    paths = [ git ];
    buildInputs = [ makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/git" \
        --set GIT_CONFIG ${dotfiles}/share/dotfiles/.gitconfig \
        --set HOME ${dotfiles}/share/dotfiles
    '';
  }
