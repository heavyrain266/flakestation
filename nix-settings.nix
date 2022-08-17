{ inputs, system, nixpkgs }:

{
  checkConfig = true;

  settings.experimental-features = [ "nix-command" "flakes" ];

  gc = {
    automatic = true;
    persistent = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixPath = let path = toString ./.;
  in [
    "repl=${path}/repl.nix"
    "nixpkgs=${nixpkgs}"
    "home-manager=${inputs.home}"
  ];

  optimise.automatic = true;

  package = inputs.master.legacyPackages.${system}.nix;

  registry = {
    system.flake = inputs.self;
    default.flake = nixpkgs;
    home-manager.flake = inputs.home;
  };

  settings = {
    accept-flake-config = true;
    allowed-users = [ "shadow" ];
    auto-optimise-store = true;
    max-jobs = "auto";
    sandbox = false;

    substituters = [
      "https://cache.nixos.org?priority=10"
      "https://cache.ngi0.nixos.org/"
      "https://nix-community.cachix.org?priority=5"
      "https://fortuneteller2k.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
    ];

    trusted-users = [ "root" "shadow" ];
  };
}
