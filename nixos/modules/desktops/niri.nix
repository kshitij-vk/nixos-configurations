# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
# Enable Niri Wayland Compositor
programs.niri.enable = true;

# Enable XWayland for X11 application compatibility
programs.xwayland.enable = true;

# Enable XDG Portals and GNOME services for full functionality
services.gnome.gnome-keyring.enable = true;
xdg.portal = {
  enable = true;
  extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  # Ensure the default is set to something that works with Wayland
  # config.common.default = "gnome"; 
};

# Add essential companion applications
environment.systemPackages = with pkgs; [
  fuzzel
  waybar
  mako
  grim
  slurp
  wl-clipboard
];
}
