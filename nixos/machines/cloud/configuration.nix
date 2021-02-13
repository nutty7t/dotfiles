# NixOS configuration for my AX41 dedicated server hosted somewhere in Germany.
# This is where I host my personal services that run in the cloud.

{ config, pkgs, ... }:

{
  imports =
    [
      <home-manager/nixos>
      ./hardware-configuration.nix
    ];

  system.stateVersion = "20.09";
  time.timeZone = "America/Phoenix";

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  # Install the GRUB boot loader on both of the SSD drives.
  # The data partitions in these drives make up a mirrored ZFS pool.
  boot.loader.grub.devices = [ "/dev/nvme0n1" "/dev/nvme1n1" ];

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9CO8jt0U3WQkJbewajZ1aAWxxr71364MVD8qclkr38TVSXemuy30AYIadCd6kXS9W2UB57KG3wZEr6suvyjF0gxH6PBhH/2QrsQu49UkwXJSwEgogpJplf1bTy38Vs9h+nLmya1VFbh6tbD7kvX4aLO9CyAgE2j3RprdkNioPCUrIPzAWSQo13NRHPhLC9NL8DZtTIr+3eyeHoX4pqMbWY+XC/83yPWQMyr13po/JpsNV0VVIyU7PJJ4wdn6TL9UBWMqhNn1akckDIpEAA3pCRvZBlBTOveEqaN425Om2nfvoGPsdiuAxhw6d6hxQx7n3DcUDDwADJPd6M4wUOnZ6NI7J2/fXAEp72dzCRkvj2YBGzwS8AxtsIn23d8EgHIX66geOdICclBERduxfEPT8o4+BhIY/KI2byz/Ximi9ukinX0pN0uBk9AS36MXRi/plJaDKD0X6UMEB8aTNzU+IK2vbDVh1PipChu0bQalemsP5sz1iYEqf8axVCZSmaqgyNYRfQ08a9JSb9speSnu8nTyPAs7+SV+/jxYJBn8UfP2FIOAmg7ob8bTLwnRGc0XpGOxkCGow6WWeV5YJxqVtoKBMD0BjT7FInYSoKxIH4mrywg5VRvew9WIzssrOCnt9nD7RWZ+OYxI8aGLictc48aRbkUBpore/uuDrFd5nfw==" ];
  users.users.nutty.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9CO8jt0U3WQkJbewajZ1aAWxxr71364MVD8qclkr38TVSXemuy30AYIadCd6kXS9W2UB57KG3wZEr6suvyjF0gxH6PBhH/2QrsQu49UkwXJSwEgogpJplf1bTy38Vs9h+nLmya1VFbh6tbD7kvX4aLO9CyAgE2j3RprdkNioPCUrIPzAWSQo13NRHPhLC9NL8DZtTIr+3eyeHoX4pqMbWY+XC/83yPWQMyr13po/JpsNV0VVIyU7PJJ4wdn6TL9UBWMqhNn1akckDIpEAA3pCRvZBlBTOveEqaN425Om2nfvoGPsdiuAxhw6d6hxQx7n3DcUDDwADJPd6M4wUOnZ6NI7J2/fXAEp72dzCRkvj2YBGzwS8AxtsIn23d8EgHIX66geOdICclBERduxfEPT8o4+BhIY/KI2byz/Ximi9ukinX0pN0uBk9AS36MXRi/plJaDKD0X6UMEB8aTNzU+IK2vbDVh1PipChu0bQalemsP5sz1iYEqf8axVCZSmaqgyNYRfQ08a9JSb9speSnu8nTyPAs7+SV+/jxYJBn8UfP2FIOAmg7ob8bTLwnRGc0XpGOxkCGow6WWeV5YJxqVtoKBMD0BjT7FInYSoKxIH4mrywg5VRvew9WIzssrOCnt9nD7RWZ+OYxI8aGLictc48aRbkUBpore/uuDrFd5nfw==" ];

  networking.hostName = "nuttycloud";
  networking.hostId = "7d3f6bd3";
  networking.usePredictableInterfaceNames = false;
  networking.interfaces.eth0.useDHCP = false;
  networking.useDHCP = false;

  systemd.network = {
    enable = true;
    networks."eth0".extraConfig = ''
      [Match]
      Name = eth0
      [Network]
      # Network IP information is available in Hetzner Robot
      # https://robot.your-server.de/server
      Address = 2a01:4f8:252:5915::2/64
      Gateway = fe80::1
      Address =  157.90.88.170/26
      Gateway = 157.90.88.129
    '';
  };

  boot.supportedFilesystems = [ "zfs" ];
  environment.systemPackages = with pkgs; [ zfs ];

  users.users.nutty = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  home-manager.users.nutty = import ../../../dotfiles.nix;
}
