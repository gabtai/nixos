{ config, pkgs, ... }:

{
  # XDG Portal támogatás (fájlválasztók, sötét mód, általános integráció)
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk # GTK fájlválasztó ablakokhoz és témákhoz
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
  };

  # XDG Mappaszerkezet segédprogram (Downloads, Pictures, stb.)
  environment.systemPackages = with pkgs; [
    xdg-user-dirs
  ];
}
