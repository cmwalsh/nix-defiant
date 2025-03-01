{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ nebula ];

  services.nebula.networks.mesh = {
    enable = true;
    isLighthouse = false;
    cert = "/etc/nebula/ds9.crt";
    key = "/etc/nebula/ds9.key";
    ca = "/etc/nebula/ca.crt";
  };
}
