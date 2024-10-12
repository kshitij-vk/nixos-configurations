{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pkgs.cloudflared
  ];

  services.cloudflared = {
    enable = true;
    user = "roxor";
    package = pkgs.cloudflared;
    tunnels = {
      "xxxx-xxxx-xxxx" = {
        credentialsFile = "${config.users.users.roxor.home}/.cloudflared/xxxx-xxxx-xxxx.json";
        default = "http_status:404";
        ingress = {
          "*.example.com" = {
            service = "http://localhost:8080";
          };
        };
      };
    };
  };

}
