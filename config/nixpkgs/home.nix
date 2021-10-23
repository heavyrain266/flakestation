{ config, pkgs, lib, ... }:

{

  imports = [
    ./dotfiles/dunst.nix
#    ./dotfiles/gtk.nix
    ./dotfiles/mako.nix
    ./dotfiles/mpv.nix
    ./dotfiles/polybar.nix
    ./dotfiles/rofi.nix
    ./dotfiles/sxhkd.nix
    ./dotfiles/terminal.nix
    ./dotfiles/zathura.nix
  ];

  programs = {
    home-manager = {
      enable = true;
      };
    };

  # TODO: more overlays
  nixpkgs = {
    overlays = [
      (import ./overlays/river.nix)
      (import ./overlays/picom.nix)
      (import ./overlays/kakoune.nix)
    ];
    config.allowUnfree = true;
  };

  home = {
    username = "fenrir";
    homeDirectory = "/home/fenrir";
    packages = with pkgs; [
      # System utils
      river
      oguri
      picom
      wmctrl
      scrcpy
      playerctl
      nix-direnv
      font-manager
      xorg.xwininfo
      gtk-layer-shell
      parinfer-rust
      # Terminals, IDEs and Editors
      foot
      vscode
      tree-sitter
      kakoune-unwrapped
      # language servers
      rnix-lsp
      gopls
      flow
      solargraph
      rust-analyzer
      sumneko-lua-language-server
      # Terminal apps and utils
      manix
      unp
      nixfmt
      unzip
      fd
      ripgrep
      xclip
      tokei
      imagemagick
      libnotify
      ranger
      # compilers
      clang
      cargo
      rustc
      # Web & music
      youtube-dl
      qutebrowser
      # Games
      minecraft
    ];
    stateVersion = "21.11";
  };

}
