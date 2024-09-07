{ config, pkgs, ... }:
{
  users.users.roxor.isNormalUser = true;

  home-manager.users.roxor = { pkgs, ... }: {
    home.packages = [ pkgs.atool pkgs.httpie ];
    programs.bash.enable = true;

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";
  };
}
