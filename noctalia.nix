{ config, pkgs, inputs, ... }:

{
  # imports = [ inputs.noctalia.nixosModules.default ];

  programs.noctalia = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
