# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, lib, inputs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Generation label
  system.nixos.label = "BSPWM-NixOS";

  # Bootloader
  time.hardwareClockInLocalTime = true;
  ### GRUB ###
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";# "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.milk-theme.enable = true;
  ### SYSTEMD ###
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  networking.hostName = "NixOS";
  networking.wireless.enable = true;

  home-manager.backupFileExtension = "bak";
  
  # bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Hyprland
  #programs.hyprland = {
  #  enable = true;
  #  xwayland.enable = true;
  #};
  # bspwm
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.bspwm.enable = true;
  };
  
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # ReGreet
  programs.regreet.enable = true;
  programs.regreet.settings = {
    background = {
      path = ./wallpapers/crimson2.jpg;
      fit = "Cover";
    };
  };
  
  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [ 5900 5000 5800 1488 11434 42153 5173 56195 ];

  # pipewire
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
  };
  
  # obs portal
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  
  # obs
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins;
    [ wlrobs ];
  };  
  
  # virtual box
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  boot.kernelModules = [ "kvm-intel" "ch341" "usbserial" ];

  # docs
  documentation.doc.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  services.ntp.enable = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";
  
  # Tuxedo-rs
  #hardware.tuxedo-drivers.enable = false;

  #hardware.tuxedo-rs = {
  #  enable = true;
  #  tailor-gui.enable = true;
  #};


  # Env variables
  environment.variables = {
    GTK_THEME = "Adwaita-dark";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  # docker
  virtualisation.docker = {
    enable = true;
  };

  #java
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };



  # Enable all firmware
  hardware.enableAllFirmware = true;

  # Fonts
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      jetbrains-mono
    ];
  };
  
  # Define a user account
  users.users.harinezumi = {
    isNormalUser = true;
    description = "HarinezumiHaven";
    extraGroups = [ "networkmanager" "wheel" "input" "audio" "tty" "dialout" "libvirtd" "kvm" "video" "docker" ];
  };

  # ZSH  
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "python3.12-ecdsa-0.19.1"
    ];
  };
  
  # Swap
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16*1024;
  }];

  # gamemode
  programs.gamemode.enable = true;

  # glx
  hardware.graphics = {
    enable = true;
  };

  environment.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk17}";
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # vibe
    clock-rs
    cmatrix
    fastfetch
    cava
    cmus
    xfce.thunar

    # bspwm
    bspwm
    sxhkd
    rofi
    feh
    picom
    polybar
    dunst
    scrot
    pamixer
    slop
    xclip
    maim
    jq
    libnotify

    # overlay
    mangohud
    goverlay
    xdotool
    
    #
    catppuccin-cursors.mochaDark
    catppuccin-cursors.mochaMauve
    # launchers
    fuzzel
    

    # screenshot
    slurp
    grim
    
    # programs
    icu
    appimage-run
    blockbench
    musescore
    sunvox
    the-powder-toy
    audacity
    ffmpeg
    ydotool
    unityhub
    libreoffice-fresh
    obsidian
    mpv
    w3m
    blender
    libresprite
    chromium
    arduino-ide
    xclicker
    pear-desktop
    cowsay
    git
    vim
    neovim
    firefox
    tor
    ayugram-desktop
    vlc
    gdu
    kalker
    feh
    discord
    zip
    unzip
    foliate
    gparted
    prismlauncher
    vscode
    jetbrains.idea
    ninja
    renpy
    krita
    
    # STEAM
    steam
    steam-unwrapped
    steam-run
    steamcmd
    openal
    udev
    libglvnd
    #openjdk21
    stdenv
    android-studio
    mesa
    bottles
    
    # system
    pavucontrol
    home-manager
    busybox
    brightnessctl
    pipewire
    xdg-desktop-portal
    gnome-themes-extra
    ntfs3g
    file
    linuxKernel.packages.linux_xanmod_stable.veikk-linux-driver

    docker

    # cloudflare
    cloudflared

    # bluetooth
    blueman
    
    # wayland devs
    wayland
    wlroots

    # Python
    python312

    # c#
    dotnet-sdk_8 
   
    # Nim
    nim
    nimble

    # C
    gcc

    # Rust
    rustc
    cargo
    rustup
    
    # Node js
    nodejs_20

    # Java
    jdk17
    gradle
    gnumake

    # tauri on linux
    pkg-config
    openssl
    #libsoup
  ];

  # STEAM
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Auto-delete generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Flakes support
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Services
  services.tailscale.enable = true;

  system.stateVersion = "25.05";
}
