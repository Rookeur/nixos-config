{ self, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
    };
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager.defaultSession = "none+i3";

  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = false;
      middleEmulation = true;
      tapping = true;
    };
  };

  programs.xfconf.enable = true;
}
