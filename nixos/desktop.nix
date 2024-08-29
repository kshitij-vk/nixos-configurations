# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# Plasma + Awesome, Bspwm, i3wm and more

{
  environment.systemPackages = with pkgs; [
    arc-kde-theme
    btop
    cava
    cmatrix
    dash
    eww
    feh
    font-awesome
    font-awesome_4
    font-awesome_5
    gnumake
    grim
    i3lock-fancy-rapid
    imlib2
    jetbrains-mono
    kate
    ksuperkey
    lolcat
    lxappearance
    mako
    materia-kde-theme
    micro
    nitrogen
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
    xfce.xfce4-terminal
    xorg.libX11.dev
    xorg.libXft
    xorg.libXinerama
    xorg.libxcb.dev
    yad
];
}
