{ config, pkgs, ... }:

{

  imports = [
    ./modules/boot
    ./modules/display
    ./modules/hardware
    ./modules/security
    ./modules/services
    ./modules/software
    ./hardware-configuration.nix
  ];

  time = {
    timeZone = "Europe/Dublin";
  };

  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;
    users = {
      fenrir = {
        isNormalUser = true;
        extraGroups = [ "wheel" "doas" "docker" "networkmanager" ];
        initialPassword = "password";
      };
    };
  };

  nix = {
    allowedUsers = [ "root" "fenrir" ];
    trustedUsers = [ "root" "fenrir" ];
    autoOptimiseStore = true;
    checkConfig = true;
    gc = {
      automatic = true;
      dates = "weekly";
    };
    optimise.automatic = true;
    useSandbox = false;
  };

  system.stateVersion = "21.11";

}
