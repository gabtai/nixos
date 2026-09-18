{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
    wineWow64Packages.staging
    winetricks
    protontricks
    protonplus
  ];

  programs = {
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
        custom = {
          start = "notify-send -a 'Gamemode' 'Optimizations activated'";
          end   = "notify-send -a 'Gamemode' 'Optimizations deactivated'";
        };
      };
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };

    steam = {
      enable = true;
      dedicatedServer.openFirewall = true;
    };
  };
}

