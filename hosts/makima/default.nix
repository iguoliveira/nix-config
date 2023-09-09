{ config, pkgs, inputs, outputs, lib, ... }:

{
  imports = [
    ../global.nix
    ./hardware.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.makima = {
    isNormalUser = true;
    description = "Makima";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      makima = import ./makima.nix;
    };
    extraSpecialArgs = { inherit inputs outputs; };
  };

  system.stateVersion = "22.11";
}