{ config, pkgs, inputs, outputs, lib, ... }:

{
  imports =
  [
    ../global.nix
    ./hardware.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.abehidek.nixosModules.shell
  ];

  modules.system = {
    shell = {
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

    services = {
      docker = {
        users = [ "iguoliveira" ];
      };
    };
  };

  users.users.iguoliveira = {
    isNormalUser = true;
    description = "Igor Oliveira";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
  };

  programs = {
    adb.enable = true;
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
    efi = {
     canTouchEfiVariables = true;
     efiSysMountPoint = "/boot/efi";
    };
    systemd-boot.enable=true;
  };

  networking = {
    networkmanager.enable = true; # Enable networking
    hostName = "titan";
  };

  services.xserver = {
      layout = "us";
      xkbVariant = "altgr-intl";
  };

  console.keyMap = "br-abnt2";

  nixpkgs.config = {
    allowNonFree = true;
  };

  system.stateVersion = "22.11"; # Careful
}
