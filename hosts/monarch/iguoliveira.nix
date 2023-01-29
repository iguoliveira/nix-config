{ lib, config, pkgs, inputs, outputs, ... }: {

    imports = [ inputs.misterio77.homeManagerModules.fonts ];

    home = {
        stateVersion = "23.05"; # DO NOT TOUCH
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
            discord
            obinskit
            qbittorrent
        ];
    };

    fontProfiles = {
        enable = true;
        monospace = {
            family = "FiraCode Nerd Font";
            package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
        };
        regular = {
            family = "Fira Sans";
            package = pkgs.fira;
        };
    };

    programs.starship.enable = true;
}
