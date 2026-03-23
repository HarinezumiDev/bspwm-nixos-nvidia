{ config, lib, pkgs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.xserver.screenSection = ''
    Option "metamodes" "1360x768 +0+0"
    Option "SLI" "Off"
    Option "MultiGPU" "Off"
    Option "BaseMosaic" "off"
  '';
}
