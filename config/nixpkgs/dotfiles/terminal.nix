{ config, pkgs, ... }:

{

#  nixpkgs.overlays = [ (import ../overlays/alacritty.nix) ];

  programs = {
    alacritty = {
      enable = true;
      package = pkgs.alacritty;
      settings = {
        env."TERM" = "xterm-256color";
        window.padding = {
          x = 12;
          y = 12;
        };
      decorations = "full";
      dynamic_padding = true;
      dynamic_title = false;
      scrolling.history = 10000;
      font = {
        size = 8;
        normal.family = "dina";
        bold.family = "dina";
        italic.family = "dina";
      };
      cursor.style = "Underline";
      colors = {
        primary = {
          background = "0x101010";
          foreground = "0xdcd9c0";
        };
        normal = {
          black   = "0x525252";
          red     = "0xe19090";
          green   = "0x99b99a";
          yellow  = "0xe0db96";
          blue    = "0xc1d0dc";
          magenta = "0xdaa6c3";
          cyan    = "0xa5d2d2";
          white   = "0xdcd9c0";
        };
        bright = {
          black   = "0x5b5b5b";
          red     = "0xfaa0a0";
          green   = "0xaaceab";
          yellow  = "0xf9f3a7";
          blue    = "0xd7e7f4";
          magenta = "0xf2b9d9";
          cyan    = "0xb7e9e9";
          white   = "0xf4f1d6";
        };
      };
    };
  };
  git = {
    enable = true;
    userName = "HeavyRain266";
    userEmail = "private";
  };
  feh.enable = true;
  fzf.enable = true;
  exa = {
    enable = true;
    enableAliases = true;
  };
  direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
};

}
