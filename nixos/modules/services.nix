# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Nix-Expermental
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  security.pam.services.login.enableGnomeKeyring = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };

  # Polkit
  security.polkit.enable = true;
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
	wants = [ "graphical-session.target" ];
	after = [ "graphical-session.target" ];
	serviceConfig = {
	Type = "simple";
	ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
	Restart = "on-failure";
	RestartSec = 1;
	TimeoutStopSec = 10;
	};
      };
    };

  security.pam.services.login.kwallet.enable = true;
  systemd.services.kwallet = {
    wantedBy = [ "default.target" ];
  };

  #ZSH
  users.defaultUserShell = pkgs.zsh;
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "npm"
          "history"
          "node"
          "rust"
          "deno"
        ];
      };
    };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Kde-Connect
  programs.kdeconnect.enable = true;

  #DOCKER
  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable Docker on system startup
  systemd.services.docker.wantedBy = [ "multi-user.target" ];


  # Jenkins
  # Enable Jenkins service
  services.jenkins = {
    enable = true;
    user = "jenkins";  # You can change this if you prefer
    group = "jenkins";
    home = "/var/lib/jenkins";
  };

  # Optionally, open the Jenkins port if you have a firewall enabled
  networking.firewall.allowedTCPPorts = [ 8080 ];

  # Optionally, configure Minikube to start on system boot
  systemd.services.minikube = {
    enable = true;
    description = "Minikube service";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.minikube}/bin/minikube start --driver=docker";
    serviceConfig.Restart = "always";
  };

  # Automatic Garbage Collection
  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
  };

  # Git Configuration
  programs.git = {
    enable = true;
#    userName = "Kshitij Koyande";
#    userEmail = "koyande72@gmail.com";
  };

  # Steam
#  programs.steam = {
#   enable = true;
#  };


}
