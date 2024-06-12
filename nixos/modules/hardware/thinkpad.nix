{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/a673a7c6-b7da-45ee-8331-4162cdf510a9";
      fsType = "ext4";
    };

  fileSystems."/rtmp" =
    {
      device = "/dev/disk/by-uuid/a673a7c6-b7da-45ee-8331-4162cdf510a9";
      fsType = "tmpfs";
      options = [ "rw" "nofail" ];
    };

  boot.initrd.luks.devices."luks-872f0852-89aa-4c52-bcbf-3ae8a44ee06a".device = "/dev/disk/by-uuid/872f0852-89aa-4c52-bcbf-3ae8a44ee06a";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/F602-23D9";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
