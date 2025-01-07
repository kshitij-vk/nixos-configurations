# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  environment.variables = {
    EDITOR = "nano";
    BROWSER = "vivaldi";
    QT_QPA_PLATFORM = "xcb";
    #QT_QPA_PLATFORMTHEME = lib.mkForce "qt5ct";
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
  };	

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME="radeonsi";
    VDPAU_DRIVER = "radeonsi";
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config.credential.helper = "libsecret";
  };

  nixpkgs.config = {
    chromium = {
    enableWideVine = true;
    };
  };
}
