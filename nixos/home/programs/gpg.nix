{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    libsForQt5.kgpg
  ];

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 60;
      maxCacheTtl = 120;
      extraConfig = ''
        pinentry-program ${pkgs.pinentry.qt}/bin/pinentry
      '';
    };
  };
}
