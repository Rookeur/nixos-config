{ system, inputs, ... }:

let
  inherit (inputs) nixpkgs;
  mkImage = path: nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [ path ];
    specialArgs = inputs;
  };


  images = {
    thinkpad = ./thinkpad.nix;
  };
in

(builtins.mapAttrs (k: v: mkImage v) images)

