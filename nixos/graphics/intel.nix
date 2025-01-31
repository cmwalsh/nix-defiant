{ pkgs, ... }: {

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };

  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      libvdpau-va-gl
      vaapiVdpau
      vpl-gpu-rt
    ];
  };

  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
}
