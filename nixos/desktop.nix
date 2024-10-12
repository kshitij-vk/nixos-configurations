# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# Plasma + Awesome, Bspwm, i3wm and more

{
  environment.systemPackages = with pkgs; [
    btop
    catppuccin
    cava
    cmatrix
    dash
    eww
    feh
    font-awesome
    font-awesome_4
    font-awesome_5
    gnome.file-roller
    gnome.gnome-keyring
    gnumake
    grim
    i3lock-fancy-rapid
    imlib2
    jetbrains-mono
    kate
    ksuperkey
    libnotify
    lolcat
    lxappearance
    mako
    micro
    nitrogen
    numix-icon-theme
    ocs-url
    pavucontrol
    picom
    python311Packages.sparklines
    pywal
    poppins
    rofi-wayland
    slstatus
    st
    sddm-kcm
    swaybg
    swaylock
    sxhkd
    waybar
    wdisplays
    wofi
    xcbuild
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.xfce4-notifyd
    xfce.xfce4-panel
    xfce.xfce4-power-manager
    xfce.xfce4-terminal
    xfce.xfce4-weather-plugin
    xfce.xfce4-whiskermenu-plugin
    xorg.libX11.dev
    xorg.libXft
    xorg.libXinerama
    xorg.libxcb.dev
    yad
];
}
