# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# Plasma + Bspwm + hyprland

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
    gnumake
    grim
    i3lock-fancy-rapid
    imlib2
    jetbrains-mono
    kate
    lolcat
    lxappearance
    mako
    materia-kde-theme
#    meslo-lgf-nf
    micro
    nitrogen
    ocs-url
    pavucontrol
    picom
    poppins
    python311Packages.sparklines
    pywal
    rofi-wayland
    slstatus
    st
    sddm-kcm
    swaybg
    sxhkd
    waybar
    wdisplays
    wofi
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.xfce4-terminal
    xorg.libX11.dev
    xorg.libXft
    xorg.libXinerama
    yad
];
}
