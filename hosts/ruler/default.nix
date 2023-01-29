{ config, pkgs, inputs, outputs, ... }:

{
  imports =
  [
    ../global.nix
    ./hardware.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.abehidek.nixosModules.shell
  ];

  modules.system.services.docker.users = [ "iguoliveira" ];

  modules.system.shell = {
    zsh = {
      enable = true;
      rice = true; # Archive file
      users = [ "iguoliveira" ];
    };
  };

  users.users.iguoliveira = {
    isNormalUser = true;
    description = "Igor Oliveira";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      iguoliveira = import ./iguoliveira.nix;
    };
    extraSpecialArgs = { inherit inputs outputs; };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  networking = {
    networkmanager.enable = true; # Enable networking
    hostName = "ruler";
  };

  services.xserver = {
      layout = "br";
      xkbVariant = "nodeadkeys";
  };

  console.keyMap = "br-abnt2";

  system.stateVersion = "22.11"; # Careful
}