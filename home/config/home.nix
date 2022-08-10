{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
      username = "shadow";
      homeDirectory = "/home/${username}";
      packages = with pkgs; [
          # System
          sway wmctrl scrcpy xorg.xwininfo gtk-layer-shell

          # Software
          foot ranger kakoune vscode

          # Libraries
          libnotify

          # Utils
          manix nixfmt rnix-lsp nix-direnv tree-sitter rust-analyzer

          # Games
          minecraft airshipper
      ];

      stateVersion = "22.05";
  };


  programs.home-manager.enable = true;
}
