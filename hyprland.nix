{ config, pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    foot
    nwg-look
    hyprcursor
  ];

  # nix.settings = {
    # substituters = [ "https://hyprland.cachix.org" ];
    # trusted-public-keys = [
      # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    # ];
  # };
}
