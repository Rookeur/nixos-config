{
  description = "Rookeur nixos configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    futils.url = "github:numtide/flake-utils/main";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/master";
    };

  };

  outputs = { self, nixpkgs, futils, home-manager }@inputs: {

    nixosConfigurations =
    let
      system = "x86_64-linux";
    in
    (import ./nixos/images { inherit system inputs; });
  } // (futils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs { inherit system; });
      in
      {
  	devShells.default = pkgs.mkShell {
		nativeBuildInputs = with pkgs; [ bashInteractive ];
        	buildInputs = with pkgs; [
          		nil
          		nixpkgs-fmt
        	];
      	};
      }));
}
