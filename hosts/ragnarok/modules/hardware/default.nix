{ config, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in {
  environment.systemPackages = [ nvidia-offload ];

  networking = {
    hostName = "ragnarok";
    networkmanager.enable = true;
  };

  hardware = {
    nvidia = {
      prime = {
        offload.enable = true;
        amdgpuBusId = "PCI:6:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      modesetting.enable = true;
      powerManagement.enable = true;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime ];
    };

    bluetooth = {
      enable = false;
      package = pkgs.bluezFull;
    };

    pulseaudio.enable = false;
    video.hidpi.enable = true;
    cpu.amd.updateMicrocode = true;
  };
}
