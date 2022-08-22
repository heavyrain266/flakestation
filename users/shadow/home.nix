{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home = {
    username = "shadow";
    homeDirectory = "/home/shadow";
    packages = with pkgs; [
      # System
      sway
      wmctrl
      scrcpy
      xorg.xwininfo
      gtk-layer-shell

      # Software
      foot
      ranger
      kakoune

      # Libraries
      libnotify

      # Utils
      nixfmt
      rnix-lsp
      nix-direnv
      tree-sitter
    ];

    stateVersion = "22.11";
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages
      (ps: with ps; [ rustup zlib openssl pkgconfig ]);
  };

  programs.home-manager.enable = true;
}
