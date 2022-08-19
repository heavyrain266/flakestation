{ config, pkgs, ... }:

{
  imports = [
    ./modules/boot
    ./modules/hardware
    ./modules/security
    ./modules/services
    ./modules/software
    ./modules/services/lowLatency.nix
    ./hardware-configuration.nix
  ];

  time.timeZone = "Europe/Amsterdam";

  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;
    users.shadow = {
      isNormalUser = true;
      extraGroups = [ "wheel" "doas" "docker" "networkmanager" ];
      initialPassword = "fs";
    };
  };

  system.stateVersion = "22.05";
}
