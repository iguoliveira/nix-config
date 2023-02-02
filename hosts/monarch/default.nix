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
      rice = true;
      users = [ "iguoliveira" ];
    };
    direnv = {
      enable = true;
      users = [ "iguoliveira" ];
    };
  };

  users.users.iguoliveira = {
    isNormalUser = true;
    description = "Igor Oliveira";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
  };

  programs.adb.enable = true;

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
    hostName = "monarch";
  };

  services.xserver = {
      layout = "us";
      xkbVariant = "altgr-intl";
  };

  console.keyMap = "br-abnt2";

  nixpkgs.config.permittedInsecurePackages = [ "electron-13.6.9" ];

  system.stateVersion = "22.11"; # Careful
}