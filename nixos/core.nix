# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# never put virtualbox,mlocate in this list

{
  environment.systemPackages = with pkgs; [
    alacritty
    android-tools
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
    chromium
    cloudflare-warp
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
    gitFull
    github-desktop
    gitkraken
    git-lfs
    dconf-editor
    gcc
    gdb
    gnome-disk-utility
    gnumake
    gradle
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
    jetbrains-toolbox
    jq
    kdePackages.kauth
    kdePackages.kcmutils
    kdePackages.kfilemetadata
    kdePackages.kglobalaccel
    kdePackages.kglobalacceld
    kdePackages.kirigami
    kdePackages.knewstuff
    kdePackages.packagekit-qt
    kdePackages.polkit-kde-agent-1
    kdePackages.sddm-kcm
    killall
    kitty
    kompose
    kubectl
    lact
    libtool
    libGL
    libGLU
    libsForQt5.kglobalaccel
    libxcrypt
    libxml2
    lm_sensors
    lollypop
    lshw
    maven
    m4
    meld
    mesa
    minikube
    most
    fastfetch
    networkmanager
    networkmanagerapplet
    ninja
    nixos-generators
    nomacs
    numlockx
    nwg-look
    platinum-searcher
    polkit_gnome
    polybar
    pipx
    python313
    python313Packages.pip
    qt6Packages.qtstyleplugin-kvantum
    ripgrep
    rxvt-unicode
    scilab-bin
    scrot
    simplescreenrecorder
    spotify
    telegram-desktop
    tree
    unzip
    variety
    vivaldi
    vivaldi-ffmpeg-codecs
    vlc
    volumeicon
    vscode
    wget
    widevine-cdm
    xdg-desktop-portal
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
