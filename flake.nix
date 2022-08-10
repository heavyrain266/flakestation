{
  description = "nixfiles - nixOS";

  inputs = {
    # Official
    master.url = "github:nixos/nixpkgs/master";
    stable.url = "github:nixos/nixpkgs/nixos-22.05";
    nixos-unstable.url = "github:nixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixOS/nixpkgs/nixpkgs-unstable";

    # Community
    nur.url = "github:nix-community/nur";
    naersk.url = "github:nix-community/naersk";
    home.url = "github:nix-community/home-manager";

    # Followers
    nixpkgs.follows = "nixpkgs-unstable";
    home.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home, ... }@inputs:
    with nixpkgs.lib;
    let
      config = {
        allowUnfree = true;
        tarball-ttl = 0;
      };

      filterNixFiles = k: v: v == "regular" && hasSuffix ".nix" k;

      importNixFiles = path:
        (lists.forEach (mapAttrsToList (name: _: path + ("/" + name))
          (filterAttrs filterNixFiles (builtins.readDir path)))) import;

    in {
      nixosConfigurations.ragnarok =
        import ./nixos/ragnarok { inherit config nixpkgs inputs; };

      homeConfigurations.shadow =
        import ./home { inherit config nixpkgs home inputs; };

      ragnarok = self.nixosConfigurations.ragnarok.config.system.build.toplevel;
    };
}
