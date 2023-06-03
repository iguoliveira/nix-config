{
  description = "My personal configs for all my nixOS environments (currently, only one :D)";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    inherit (self) outputs;
    sysArch = "x86_64-linux";
    libPath = nixpkgs.lib;
  in {
    nixosConfigurations = {
      # Home Main Desktop
      aki = libPath.nixosSystem {
        system = sysArch;
        modules = [ ./hosts/aki ];
        specialArgs = { inherit inputs outputs; };
      };
    };
  };
}
