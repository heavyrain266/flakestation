{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      git wget curl cachix firefox kakoune
      alacritty alsa-utils gdk-pixbuf gtk_engines
      polkit_gnome gtk-layer-shell gtk-engine-murrine
      gobject-introspection xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk gsettings-desktop-schemas
    ];
    pathsToLink = [ "/libexec" ];
  };

  fonts.fonts = with pkgs; [
    dina-font noto-fonts julia-mono
    noto-fonts-cjk noto-fonts-emoji
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  programs = {
    npm = {
      enable = true;
      npmrc = ''
        prefix = ''${HOME}/.npm
        color = true
      '';
    };
    java.enable = true;
    dconf.enable = true;
  };
}
