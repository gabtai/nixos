{ config, pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    foot
    nwg-look
    hyprcursor
  ];

  # XDG Portal támogatás (fájlválasztók, sötét mód, általános integráció)
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk # GTK fájlválasztó ablakokhoz és témákhoz
    ];
    config.common.default = "*";
  };
}
