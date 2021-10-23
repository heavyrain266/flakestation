{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      git
      sbt
      wget
      curl
      dotty
      metals
      cachix
      nodejs
      kakoune
      alsa-utils
      gdk_pixbuf
      gtk_engines
      polkit_gnome
      google-chrome
      gtk-layer-shell
      gtk-engine-murrine
      gobject-introspection
      xdg-desktop-portal-wlr
      gsettings-desktop-schemas
    ];
    pathsToLink = [ "/libexec" ];
  };

  fonts.fonts = with pkgs; [
    dina-font
    noto-fonts
    julia-mono
    cascadia-code
    noto-fonts-cjk
    noto-fonts-emoji
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

  services.dbus.enable = true;

}
