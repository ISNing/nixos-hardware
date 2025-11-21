{
  lib,
  config,
  ...
}:
{
  imports = [
    ../../../common/cpu/intel/raptor-lake
    ../../../common/gpu/nvidia/prime.nix
    ../../../common/gpu/nvidia/ada-lovelace
    ../../../common/pc/laptop
    ../../../common/pc/ssd
    ../../../common/hidpi.nix
  ];

  hardware = {
    nvidia = {
      powerManagement.enable = lib.mkDefault true;
      #
      prime = {
        intelBusId = "PCI:00:02:0";
        nvidiaBusId = "PCI:01:00:0";
      };
    };
  };

  # Sound speaker fix, see #1039
  boot.extraModprobeConfig = ''
    options snd-hda-intel model=auto
  '';

  boot.blacklistedKernelModules = [ "snd_soc_avs" ];

  # Cooling management
  services.thermald.enable = lib.mkDefault true;

  # √(3200 + 2000) px / 16 in ≃ 236 dpi
  services.xserver.dpi = 236;
}
