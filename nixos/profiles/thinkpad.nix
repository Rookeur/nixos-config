{ self, pkgs, lib, config, home-manager, writeShellScriptBin, ... }:

{
  imports = [
    ../modules/hardware/thinkpad.nix
    home-manager.nixosModules.home-manager
    {
      home-manager.extraSpecialArgs = {
        pkgs = pkgs;
      };
      home-manager.users.adrien = import ../home/users/adrien/adrien_thinkpad.nix;
    }
  ];

  users.users.adrien = {
    isNormalUser = true;
    description = "Adrien LANGOU";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };

  programs.zsh.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd.network.enable = true;

  networking = {
    networkmanager.enable = true;
    hostName = "rookeur";
    enableIPv6 = true;
    extraHosts = ''
      127.0.0.1 net2.example.org
      127.0.0.1 rookeur.org
      127.0.0.1 oidc-provider
      100.64.5.100 console.storage.prologin.eu
    '';
    nftables = {
      enable = true;
      flushRuleset = true;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8000 ];
    };
  };

  services.resolved.enable = false;

  time.timeZone = "Europe/Paris";

  i18n = {
    defaultLocale = "en_US.utf8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.utf8";
      LC_IDENTIFICATION = "fr_FR.utf8";
      LC_MEASUREMENT = "fr_FR.utf8";
      LC_MONETARY = "fr_FR.utf8";
      LC_NAME = "fr_FR.utf8";
      LC_NUMERIC = "fr_FR.utf8";
      LC_PAPER = "fr_FR.utf8";
      LC_TELEPHONE = "fr_FR.utf8";
      LC_TIME = "fr_FR.utf8";
    };
  };

  fonts.packages = with pkgs; [
    inconsolata-nerdfont
    inconsolata
  ];

  security.rtkit.enable = true;

  services.xserver.dpi = 120;

  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE = 1;
      TLP_WARN_LEVEL = 3;
      TLP_DEFAULT_MODE = "BAT";

      SOUND_POWER_SAVE_ON_AC = 1;
      SOUND_POWER_SAVE_ON_BAT = 1;

      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
      RESTORE_THRESHOLDS_ON_BAT = 1;

      NATACPI_ENABLE = 1;
      TPACPI_ENABLE = 1;
      TPSMAPI_ENABLE = 1;

      DISK_DEVICES = "nvme0n1";
      DISK_APM_LEVEL_ON_AC = "254";
      DISK_APM_LEVEL_ON_BAT = "128";
      DISK_SPINDOWN_TIMEOUT_ON_AC = "0";
      DISK_SPINDOWN_TIMEOUT_ON_BAT = "0";
      DISK_IOSCHED = "mq-deadline";
      AHCI_RUNTIME_PM_ON_BAT = "auto";

      RADEON_DPM_STATE_ON_AC = "performance";
      RADEON_DPM_STATE_ON_BAT = "battery";

      NMI_WATCHDOG = 0;

      WOL_DISABLE = "Y";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      SCHED_POWERSAVE_ON_AC = 0;
      SCHED_POWERSAVE_ON_BAT = 1;
    };
  };

  environment.systemPackages = with pkgs; [
    clang
    cmake
    firefox
    gcc
    git
    gnumake
    gnupg
    libfido2
    libykclient
    libyubikey
    man-pages
    man-pages-posix
    networkmanagerapplet
    pcsclite
    pinentry-curses
    powertop
    python3
    vim
    virtualbox
    vmware-workstation
    wget
    yubico-pam
    yubico-piv-tool
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-touch-detector
    yubioath-flutter
    zsh
  ];

  users.extraGroups.vboxusers.members = [ "adrien" ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
      "experimental-features = nix-command flakes";
  };

  documentation.dev.enable = true;
  documentation.man.generateCaches = true;

  security.krb5 = {
    enable = true;
    settings = {
      libdefaults = {
        default_realm = "PROLOGIN.ORG";
        dns_fallback = true;
        dns_canonicalize_hostname = false;
        rnds = false;
        forwardable = false;
      };

      domain_realm = {
        "prologin.eu" = "PROLOGIN.EU";
        ".prologin.eu" = "PROLOGIN.EU";
      };

      realms = {
        "PROLOGIN.ORG" = {
          admin_server = "kerberos.prologin.org";
          default_principal_flags = "+preauth";
          kdc = [ "kerberos.prologin.org" ];
        };
        "PROLOGIN.EU" = {
          admin_server = "kerberos.prologin.eu";
          default_principal_flags = "+preauth";
          kdc = [ "kerberos.prologin.eu" ];
        };
      };
    };
  };

  system.stateVersion = "22.11"; # Did you read the comment?
}
