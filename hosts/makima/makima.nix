{ lib, config, pkgs, inputs, outputs, ... }:

{
  home = {
    stateVersion = "23.05";
    username = "makima";
    homeDirectory = "/home/makima";
    packages = with pkgs; [
      vivaldi
      vscode
      git
      neofetch
      discord
      qbittorrent
      openssl
      bitwarden
      vlc
      obsidian
    ];
  };

  programs.git = {
    enable = true;
    userName = "iguoliveira";
    userEmail = "igor.or042@gmail.com";
  };
}