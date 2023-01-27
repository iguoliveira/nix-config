{ lib, config, pkgs, ... }: {
    home = {
        stateVersion = "23.05"; # do not change this
        username = "iguoliveira";
        homeDirectory = "/home/iguoliveira";
        packages = with pkgs; [
            postman
            helix
            brave
            nodejs
            git
            starship
            vscode
            nodePackages_latest.pnpm
            neofetch
        ];
    };
}
