{ config, pkgs, ... }: {
  stylix = {
    enable = true;

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/grayscale-dark.yaml";

    image = ./wallpapers/crimson2.png;
    polarity = "dark";

    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;

      sizes.terminal = 10;
    };

    opacity = {
      desktop = 0.3;
      terminal = 0.7;
    };
  };

  environment.systemPackages = with pkgs; [ base16-schemes ];
}

