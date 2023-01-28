{
  description = "Setup my system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ... 
  } @ inputs : 
  let inherit (self) outputs; in {
    nixosConfigurations = {
      ruler = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/ruler ];
        specialArgs = { inherit inputs outputs; };
      };
    };
    {
      monarch = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/monarch ];
        specialArgs = { inherit inputs outputs };
      };
    };
    # packages.x86_64-linux.pacotefoda = nixpkgs.legacyPackages.x86_64-linux.hello;
  };
}
