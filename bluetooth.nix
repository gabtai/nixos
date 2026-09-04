{ config, pkgs, ...}:

{
  # Bluetooth support enable
  hardware.bluetooth = {
   enable = true;
   powerOnBoot = true;
  };

  services.blueman.enable = true;

  # Wireplumber bluetooth fine tune
  services.pipewire.wireplumber.extraConfig.bluetoothEnchancements = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
    };   
  };
}
