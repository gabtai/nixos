{ config, pkgs, ... }:

{
  # Doas engedélyezése
  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        persist = true;
      }
    ];
  };

  # Disable sudo
  security.sudo.enable = false;

  # Create sylink for sudo
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "sudo" ''
      exec doas "$@"
    '')
  ];
}
