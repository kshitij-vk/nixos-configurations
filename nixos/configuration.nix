# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
      ./core.nix
      ./desktop.nix
      ./desktops/hyprland.nix
      ./env-vars.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.timeout = 12;
  boot.loader.grub.gfxmodeEfi = "1920x1080";
  boot.loader.grub.extraEntries = ''
    menuentry "Windows Boot Manager" {
      search --file --no-floppy --set=root /efi/Microsoft/Boot/bootmgfw.efi
      chainloader /efi/Microsoft/Boot/bootmgfw.efi
    }
  '';

  boot.loader.grub.default = 1;


  # Swappiness
  boot.kernel.sysctl = { "vm.swappiness" = 10;};

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  hardware.cpu.amd.updateMicrocode = true;

  # Nix-Expermental
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  # Steam
  programs.steam.enable = true;


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
  enable = true;
  theme = "catppuccin-mocha";
  wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.roxor = {
    isNormalUser = true;
    description = "Roxor";
    extraGroups = [ "networkmanager" "wheel" "docker" "jenkins" "warp-svc" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };


  # Home-Manager

  home-manager.users.roxor = { pkgs, ... }: {
    home.packages = with pkgs; [ ];
    home.stateVersion = "24.11";

  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  
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

  # Automatic Garbage Collection
  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
  };

  # Network
  services.avahi = {
    enable = true;
    #nssmdns = true;
    nssmdns4 = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
                  enable = true;
      workstation = true;
        };
  };

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
        Environment = "WAYLAND_DISPLAY=wayland-1";  # Set the correct Wayland socket using "echo $WAYLAND_DISPLAY"
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
        "openssl-1.1.1w" "electron-19.1.9" "python3.11-youtube-dl-2021.12.17"
  ];
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  security.pam.services.login.kwallet.enable = true;
  systemd.services.kwallet = {
    wantedBy = [ "default.target" ];
  };

}
