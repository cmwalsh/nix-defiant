{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ nebula ];

  services.nebula.networks.mesh = {
    enable = true;
    isLighthouse = false;
    cert = "/etc/nebula/ds9.crt"; # The name of this lighthouse is beacon.
    key = "/etc/nebula/ds9.key";
    ca = "/etc/nebula/ca.crt";
  };
}
