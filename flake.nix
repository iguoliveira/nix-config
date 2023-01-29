{
  description = "Personal OS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    abehidek.url = "github:abehidek/nix-config";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    abehidek,
    ... 
  } @ inputs : 
  let
    inherit (self) outputs;
    sysArch = "x86_64-linux";
    libPath = nixpkgs.lib;
  in {
    nixosConfigurations = {
      # Home desktop env
      monarch = libPath.nixosSystem {
        system = sysArch;
        modules = [ ./hosts/monarch ];
        specialArgs = { inherit inputs outputs; };
      };
      # Pendrive env
      ruler = libPath.nixosSystem {
        system = sysArch;
        modules = [ ./hosts/ruler ];
        specialArgs = { inherit inputs outputs; };
      };
    };
  };
}