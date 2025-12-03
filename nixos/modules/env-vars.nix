# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  environment.variables = {
    EDITOR = "code";
    BROWSER = "google-chrome-stable";
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
    QT_QPA_PLATFORM = "wayland";
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config.credential.helper = "libsecret";
  };
  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.roxor = {
    isNormalUser = true;
    description = "Roxor";
    extraGroups = [ "networkmanager" "wheel" "docker" "jenkins" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = false;
  services.displayManager.autoLogin.user = "roxor";

}
