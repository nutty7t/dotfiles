{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.secrets;
  gpg = import ../../../gpg/keyring.nix;

  secret = types.submodule {
    options = {
      secretFile = mkOption {
        type = types.path;
        description = ''
          The file containing the secrets. It will be encrypted inside in the
          Nix store, and then decrypted and written to the mount path by a
          systemd service.
        '';
      };

      mountPath = mkOption {
        type = types.path;
        description = "Path specifying where the decrypted secret will be mounted.";
      };

      owner = mkOption {
        type = types.str;
        default = "root";
        description = "User ownership of the decrypted secret.";
      };

      group = mkOption {
        type = types.str;
        default = "root";
        description = "Group ownership of the decrypted secret.";
      };

      permissions = mkOption {
        type = types.str;
        default = "root";
        description = "File permissions of the decrypted secret (expressed in octal).";
      };
    };

  };

  mkSecret = name:
    { secretFile, ... }:
    pkgs.stdenv.mkDerivation {
      name = "${name}-secret";
      phases = "installPhase";
      buildInputs = [ pkgs.gnupg pkgs.sops ];
      installPhase = ''
        export GNUPGHOME=$(pwd)
        gpg --import ${gpg.nuttycloud.publicKey}
        sops --encrypt --pgp ${gpg.nuttycloud.fingerprint} --output $out ${secretFile}
      '';
    };

  mkService = name:
    { secretFile, mountPath, owner, group, permissions, ... }: {
      description = "Decrypt secrets for ${name}";
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "oneshot";
      script = with pkgs; ''
        # Delete the old secret.
        rm -rf ${mountPath}

        # Decrypt the new secret.
        export SOPS_GPG_EXEC=${gnupg}/bin/gpg
        mkdir -p $(dirname ${mountPath})
        ${sops}/bin/sops --decrypt --output ${mountPath} ${
          mkSecret name { inherit secretFile; }
        }

        # Set file permissions for decrypted secret.
        chown ${owner}:${group} ${mountPath}
        chown ${permissions} ${mountPath}
      '';
    };

in {
  options.services.secrets = mkOption {
    type = types.attrsOf secret;
    default = { };
    description = "Secrets Configuration";
  };

  config.systemd.services =
    let
      units = mapAttrs' (name: info: {
        name = "${name}-key";
        value = (mkService name info);
      }) cfg;
    in units;
}
