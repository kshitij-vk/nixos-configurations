# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  maybeHardware = if builtins.pathExists "/etc/nixos/hardware-configuration.nix"
                  then [ /etc/nixos/hardware-configuration.nix ]
                  else [];
in {
  imports = maybeHardware ++ [
    ../modules/services.nix
    ../modules/env-vars.nix
    ../modules/desktops/hyprland.nix
    ../modules/packages/core.nix
    ../modules/packages/desktop.nix
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

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # List packages installed in system profile. To search, run:
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
  system.stateVersion = "25.05"; # Did you read the comment?

  nixpkgs.config.permittedInsecurePackages = [
        "openssl-1.1.1w" "electron-19.1.9" "python3.11-youtube-dl-2021.12.17"
  ];

}
