{ config, pkgs, ... }: {

  environment.systemPackages = [ pkgs.tailscale ];

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
