{ config, pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    foot
    nwg-look
    hyprcursor
    grim
    rofi
    slurp
    swappy
    thunar
  ];
}
