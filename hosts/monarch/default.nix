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
     efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      devices = [ "nodev" ];
    };
  };

  networking = {
    networkmanager.enable = true; # Enable networking
    hostName = "monarch";
  };

  services.xserver = {
      layout = "us";
      xkbVariant = "altgr-intl";
      videoDrivers = ["nvidia"];
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  console.keyMap = "br-abnt2";

  nixpkgs.config = {
    permittedInsecurePackages = [ "electron-13.6.9" ];
    allowNonFree = true;
  };

  system.stateVersion = "22.11"; # Careful
}
