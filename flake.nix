{
  description = "Personal OS";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    abehidek.url = "github:abehidek/nix-config";
    misterio77.url = "github:misterio77/nix-config";
    nix-colors.url = "github:misterio77/nix-colors";
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
      # Home Desktop
      monarch = libPath.nixosSystem {
        system = sysArch;
        modules = [ ./hosts/monarch ];
        specialArgs = { inherit inputs outputs; };
      };
      # Mobile Environment
      titan = libPath.nixosSystem {
        system = sysArch;
        modules = [ ./hosts/titan ];
        specialArgs = { inherit inputs outputs; };
      };
    };
  };
}