{ config, pkgs, ... }: {
  home.username = "harinezumi";
  home.stateVersion = "25.05";
    
  imports = [
    ./zsh.home.nix
    ./kitty.home.nix
    ./yazi.home.nix
    ./btop.home.nix
  ];  
  
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaPink;
    name = "catppuccin-mocha-dark-cursors";
    size = 18;
  };
  
  programs.home-manager.enable = true;
}
