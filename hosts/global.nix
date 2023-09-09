{ config, pkgs, inputs, outputs, ... }:

{
  imports = [
    ./makima/hardware.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };

  environment.shellAliases = {
    bld = "sudo nixos-rebuild switch --flake";
  };

  time.timeZone = "America/Sao_Paulo";

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      layout = "us";
      xkbVariant = "altgr-intl";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    printing.enable = true;
  };

  sound.enable = true;
  security.rtkit.enable = true;

  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
    };
    pulseaudio.enable = false;
  };

  nixpkgs.config.allowUnfree = true;

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
    hostName = "makima";
    networkmanager.enable = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };
}
