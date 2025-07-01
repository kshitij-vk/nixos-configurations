# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# never put virtualbox,mlocate in this list

{
  environment.systemPackages = with pkgs; [
    android-file-transfer
    ansible
    amdvlk
    arandr
    arc-theme
    avahi
    autoconf
    automake
    baobab
    bash-completion
    bat
    bibata-cursors
    bison
    blueberry
    btop
    cacert
    ccache
    curl
    dex
    dmenu
    docker
    docker-compose
    distrobox
    duf
    edid-decode
    evince
    feh
    filezilla
    firefox
    font-manager
    fsearch
    gh
    gitFull
    git-lfs
    github-desktop
    google-chrome
    gparted
    dconf-editor
    gcc
    gdb
    gnome-disk-utility
    gnumake
    gvfs
    hack-font
    hblock
    hw-probe
    hwinfo
    hyprpolkitagent
    i3lock-fancy
    inkscape
    insync
    inxi
    jdk
    jetbrains.pycharm-professional
    jq
    killall
    kubectl
    lact
    libtool
    libGL
    libGLU
    libsForQt5.polkit-qt
    libxcrypt
    libxml2
    lm_sensors
    lollypop
    lshw
    m4
    meld
    mesa
    minikube
    most
    fastfetch
    networkmanager
    networkmanagerapplet
    ninja
    numlockx
    nwg-look
    platinum-searcher
    polkit
    polkit_gnome
    polybar
    pipx
    python3Full
    ripgrep
    rxvt-unicode
    scrot
    simplescreenrecorder
    telegram-desktop
    tree
    unzip
    vlc
    volumeicon
    vscode
    wget
    widevine-cdm
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xorg.xkill
    xorg.libX11
    zip
    zsh
    zsh-autosuggestions 
    zsh-completions
    zsh-powerlevel10k
    zsh-syntax-highlighting
  ];

  #amdgpu
  hardware.graphics = {
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      libvdpau-va-gl
      libva
      libva-vdpau-driver
    ];
    # For 32 bit applications
#    extraPackages32 = with pkgs.driversi686Linux; [
#      libvdpau-va-gl
#      libva-vdpau-driver
#    ];
#    enable = true;
#    # driSupport = true;
#    driSupport32Bit = true;
  };

}
