{ config, pkgs, ... }:

{
  security = {
    doas = {
      enable = true;
      extraRules = [{
        groups = [ "doas" ];
        noPass = true;
        keepEnv = true;
      }];
    };

    polkit.enable = true;
    rtkit.enable = true;
  };
}
