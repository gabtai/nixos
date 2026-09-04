{
  description = "Nix Hyprland lua";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland.inputs.nixpkgs.follows = "nixpkgs";
    # nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    # noctalia.inputs.nixpkgs.follows = "nixpkgs";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };
 
 
  outputs = { self, nixpkgs, chaotic, noctalia, ... }@inputs: { 
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
	chaotic.nixosModules.default
      ];
    };
  };
}
