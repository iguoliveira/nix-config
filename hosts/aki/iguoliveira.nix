{ lib, config, pkgs, inputs, outputs, ... }:
{
  home = {
    stateVersion = "23.05"; # DON'T TOUCH
    username = "iguoliveira";
    homeDirectory = "/home/iguoliveira";
    packages = with pkgs; [
      vivaldi
      git
      vscode
      neofetch
      discord
      qbittorrent
      openssl
      openssh
      bitwarden
      obsidian
      vlc
      nodejs
    ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    bash.enable = true;
  };
}