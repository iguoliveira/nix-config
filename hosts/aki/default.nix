{ config, pkgs, inputs, outputs, lib, ... }:

{
  imports =
    [ ../global.nix
    ./hardware.nix
    inputs.home-manager.nixosModules.home-manager ];

  users.users.iguoliveira = {
    isNormalUser = true;
    description = "Igor Oliveira";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix.extraOptions = ''
  keep-outputs = true
  keep-derivations = true
  '';

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      iguoliveira = import ./iguoliveira.nix;
    };
    extraSpecialArgs = { inherit inputs outputs; };
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "aki";
  };

  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "22.11"; # DON'T TOUCH
}

