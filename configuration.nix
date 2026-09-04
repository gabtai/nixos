{
  config, lib, pkgs, inputs, ... }:

  {
    imports = [ 
      ./hardware-configuration.nix
      ./amdgpu.nix
      ./appimage.nix
      ./bluetooth.nix
      ./doas.nix
      ./env.nix
      ./gamemode.nix
      ./hyprland.nix
      ./noctalia.nix
      ./xdg.nix
      ./zsh.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  # Boot settings
  boot.kernelParams = [ "quiet" ];

  # CachyOS inspired low latency settings
  boot.kernel.sysctl = {
    # Memory & I/O Management
    "vm.swappiness" = 150;
    "vm.page-cluster" = 0;
    
    # Proton / Gaming és Általános Stabilitás
    "vm.max_map_count" = 2147483642;
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/5f0ebe10-4777-4e33-9e80-8ba49eb785fc";
    fsType = "btrfs";
    options = [ "defaults" "nofail" "noatime" ];
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/11053aba-9a10-4587-9bf3-c8b0ef3efe5a";
    fsType = "ext4";
    options = [ "defaults" "nofail" "noatime" ];
  };

  networking.hostName = "nixos"; # Define your hostname.

  # PIPEWIRE & AUDIO
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # 32-bit audio support
    pulse.enable = true;
    jack.enable = true;
  };

  # Configure network connections interactively with iwd.
  networking.networkmanager = {
    enable = false;
    #wifi.backend = "iwd";
  };

  # Az iwd démon explicit engedélyezése
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        EnableNetworkConfiguration = true;
      };
      Network = {
        EnableIPv6 = true;
      };
      Settings = {
        AutoConnect = true;
      	#Country = "HU";
      };
    };
  };

  networking.wireless.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Budapest";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gabtai = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "Tomi";
    packages = with pkgs; [
      rofi
      thunar
    ];
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    adw-gtk3
    brave-origin
    neovim
    ffmpeg
    fastfetch
    git
    grim
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    lutris
    steam
    slurp
    swappy
    wineWow64Packages.staging
    winetricks
    protontricks
    protonplus
  ];
  
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "x86_64-linux";
 
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  fonts.packages = with pkgs; [
    # UI és Dokumentumok (Cikkek, Web, Rofi, Waybar)
    inter                    # Modern, gyönyörű UI font
    liberation_ttf           # Microsoft Arial/Times New Roman kompatibilitás

    # Terminál & Ikonok (Foot, Neovim, Hyprland)
    nerd-fonts.jetbrains-mono # Kódolás és fejlesztői ikonok

    # Emojik
    noto-fonts-color-emoji   # Színes emojik
  ];

  # Default fontconfig 
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Inter" "Liberation Sans" ];
      serif     = [ "Liberation Serif" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
      emoji     = [ "Noto Color Emoji" ];
    };
  };

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "hu_HU.UTF-8";
    LC_IDENTIFICATION = "hu_HU.UTF-8";
    LC_MEASUREMENT = "hu_HU.UTF-8";
    LC_MONETARY = "hu_HU.UTF-8";
    LC_NAME = "hu_HU.UTF-8";
    LC_NUMERIC = "hu_HU.UTF-8";
    LC_PAPER = "hu_HU.UTF-8";
    LC_TELEPHONE = "hu_HU.UTF-8";
    LC_TIME = "hu_HU.UTF-8";
  };

  # Nix Package Management settings
  nix = {
    settings = {
      auto-optimise-store = true;
      download-buffer-size = 524288000; # 500 MB letöltési puffer a gyorsabb letöltésekért
      experimental-features = [ "nix-command" "flakes" ];

      substituters = [
        "https://cache.nixos.org"
        "https://noctalia.cachix.org"
	"https://nyx-cache.chaotic.cx"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
	"nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk="
      ];
    };

    # Garbage Collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "26.05";

}

