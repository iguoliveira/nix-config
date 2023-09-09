{
  description = "Iguoliveira's personal config for NixOS";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs :
  let
    inherit (self) outputs;
    sysArch = "x86_64-linux";
    libPath = nixpkgs.lib;
  in {
    nixosConfigurations = {
      makima = libPath.nixosSystem {
        system = sysArch;
        modules = [
          ./hosts/makima
        ];
        specialArgs = { inherit inputs outputs; };
      };
    };
  };
}