{ pkgs, ... }: {

  environment = {
    systemPackages = with pkgs; [
      git
      micro
      vim
      lazygit
      curl
      dnsutils
      iperf3
      pciutils
      rsync
      tree
      lsof
      tmux
      usbutils
      wget
      nmap
      magic-wormhole
      unzip
      borgbackup
      figurine
      stow
      podman
      zoxide
      eza
      bat
      mc
      fzf
    ];

    variables = {
      EDITOR = "micro";
      SYSTEMD_EDITOR = "micro";
      VISUAL = "micro";
    };
  };
}
