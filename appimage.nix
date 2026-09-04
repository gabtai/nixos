{ config, pkgs, ... }:

{
# AppImage support enable 
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
