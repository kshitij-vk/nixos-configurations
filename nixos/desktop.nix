# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# Plasma + Awesome, Bspwm, i3wm and more

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    btop
    catppuccin
    catppuccin-sddm
    dash
    dart-sass
    dejavu_fonts
    eww
    font-awesome
    font-awesome_4
    font-awesome_5
    file-roller
    gnome-keyring
    gnome-tweaks
    gnumake
    gpustat
    grim
    gsettings-qt
    hyprsunset
    hypridle
    i3lock-fancy-rapid
    imlib2
    jetbrains-mono
    kate
    ksuperkey
    libgtop
    libnotify
    libsecret
    libsForQt5.qt5ct
    lightly-boehs
    lolcat
    lxappearance
    matugen
    mako
    meslo-lgs-nf
    micro
    nitrogen
    numix-icon-theme
    ocs-url
    pavucontrol
    picom
    python312Packages.sparklines
    python312Packages.gpustat
    pywal
    poppins
    rofi-wayland
    slstatus
    st
    swaylock
    swaybg
    sxhkd
    waybar
    waypaper
    wdisplays
    windows10-icons
    wl-clipboard
    wofi
    xcbuild
    xorg.libX11.dev
    xorg.libXft
    xorg.libXinerama
    xorg.libxcb.dev
    yad
];
}
