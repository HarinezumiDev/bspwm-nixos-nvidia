{ config, lib, pkgs, inputs, ... }: {

  {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.open = true;
  };

}
