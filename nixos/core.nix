# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# never put virtualbox,mlocate in this list

{
  environment.systemPackages = with pkgs; [
    alacritty
    amdvlk
    arandr
    arc-theme
    avahi
    baobab
    bash-completion
    bat
    bibata-cursors
    blueberry
    btop
    chromium
    curl
    dex
    discord
    dmenu
    docker
    docker-compose
    duf
    edid-decode
    evince
    feh
    filezilla
    firefox
    flameshot
    font-manager
    fsearch
    gimp
    git
    gnome.dconf-editor
    gnome.gnome-disk-utility
    gnome.gvfs
    hack-font
    hblock
    hw-probe
    hwinfo
    i3lock-fancy
    inkscape
    insync
    inxi
    killall
    kitty
    kompose
    kubectl
    lact
    lm_sensors
    lollypop
    lshw
    meld
    minikube
    most
    fastfetch
    networkmanagerapplet
    nixos-generators
    nomacs
    numlockx
    platinum-searcher
    polybar
    qt6Packages.qtstyleplugin-kvantum
    ripgrep
    rxvt-unicode
    scrot
    simplescreenrecorder
    spotify
    sublime4
    telegram-desktop
    tree
    variety
    vivaldi
    vivaldi-ffmpeg-codecs
    vlc
    volumeicon
    vscode
    wget
    widevine-cdm
    xorg.xkill
    yakuake
    zsh
    zsh-completions
    zsh-syntax-highlighting
  ];

  #amdgpu
  hardware.opengl = {
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      libvdpau-va-gl
      libva
      libva-vdpau-driver
    ];
    # For 32 bit applications
    extraPackages32 = with pkgs.driversi686Linux; [
      libvdpau-va-gl
      libva-vdpau-driver
    ];
    enable = true;
    # driSupport = true;
    driSupport32Bit = true;
  };

}
