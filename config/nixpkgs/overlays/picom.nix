self: super:

{

  picom = super.picom.overrideAttrs (oldAttrs: rec {
    src = builtins.fetchTarball {
        url = "https://github.com/pijulius/picom/archive/implement-window-animations.tar.gz";
    };
  });

}
