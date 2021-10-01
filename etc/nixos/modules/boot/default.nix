{ config, pkgs, ... }:

{

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        trustedBoot.isHPLaptop = true;
      };
    };
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_xanmod;
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    kernelModules = [ "kvm-amd" "amdgpu" ];
    initrd.kernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "sdhci_pci"
    ];
  };

  i18n.defaultLocale = "en_GB.UTF-8";

  console.keyMap = "pl";

  virtualisation = {
    libvirtd = {
      enable = false;
      qemuOvmf = false;
      qemuPackage = pkgs.qemu;
      onBoot = [ "start" ];
      onShutdown = [ "shutdown" ];
    };
    docker = {
      enable = false;
      package = pkgs.docker;
      enableOnBoot = true;
    };
  };

}
