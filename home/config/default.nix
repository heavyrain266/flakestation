{ config, nixpkgs, home, discocss, overlays, inputs }:

home.lib.homeManagerConfiguration rec {
  system = "x86_64-linux";
  username = "shadow";
  homeDirectory = "/home/${username}";

  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

  configuration.imports = [ ./home.nix ];

  extraSpecialArgs = { };

  stateVersion = "22.05";
}
