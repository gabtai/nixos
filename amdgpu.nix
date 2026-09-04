{ config, pkgs, ... }:

{

# Load AMD driver for Xorg and Wayland
 services.xserver.videoDrivers = ["amdgpu"];

  #Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau-va-gl
        libva
        vulkan-loader
        vulkan-validation-layers
      ];
      extraPackages32 = with pkgs; [
        libva-vdpau-driver
        libvdpau-va-gl
        libva
       
      ];
    };
  #  environment.systemPackages = with pkgs; [
    # lact
  # ];

  # systemd.services.lact = {
    # description = "AMDGPU Control Daemon";
    # after = ["multi-user.target"];
    # wantedBy = ["multi-user.target"];
    # serviceConfig = {
      # ExecStart = "${pkgs.lact}/bin/lact daemon";
    # };
    # enable = true;
  # };

 }
