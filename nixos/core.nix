# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# never put virtualbox,mlocate in this list

{
  environment.systemPackages = with pkgs; [
    alacritty
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
    duf
    edid-decode
    evince
    etcd
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
    istioctl
    kona
    killall
    kitty
    kubectl
    k6
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
}
