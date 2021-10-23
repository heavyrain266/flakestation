{ config, pkgs, ... }:

{
  programs = {
    zathura = {
      enable = true;
      package = pkgs.zathura;
      options = {
        default-fg = "#dcd9c0";
        inputbar-fg = "#dcd9c0";
        statusbar-fg = "#99b99a";
        default-bg = "#101010";
        inputbar-bg = "#1616160";
        statusbar-bg = "#161616";
        font = "Dina 9";
        recolor-lightcolor = "#101010";
        recolor-darkcolor = "#dcd9c0a";
      };
      extraConfig = ''
        set recolor
        set recolor-keephue
      '';
    };
  };
}
