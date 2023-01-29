{ lib, config, pkgs, inputs, outputs, ... }:
let
    colorScheme = inputs.nix-colors.colorSchemes.dracula.colors;
in {
    imports = [
        inputs.misterio77.homeManagerModules.fonts
        inputs.abehidek.userModules.desktop
        inputs.nix-colors.homeManagerModule
    ];

    modules.user.desktop = {
        term.kitty = {
            enable = true;
            font = {
                enable = true;
                family = "FiraCode Nerd Font";
                package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
            };
            colors = {
                enable = true;
                base16 = colorScheme;
            };
        };
    };

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
