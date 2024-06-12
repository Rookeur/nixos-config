{ self, ... }:

{
  imports = [
    ../profiles/thinkpad.nix
    ../modules/bluetooh.nix
    ../modules/gpg-agent.nix
    ../modules/i3.nix
    ../modules/printer.nix
    ../modules/sound.nix
    ../modules/virtualisation.nix
    ../modules/yubikey.nix
  ];
}
