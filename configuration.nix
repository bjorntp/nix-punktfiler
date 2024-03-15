{ config, pkgs, ... }:

{ 
  
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    wget
    alsa-utils
    killall
    i3
    openssh
    htop
    git
    gcc
    xclip
    vim
    lunarvim
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  hardware = {
    pulseaudio.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  time.timeZone = "Europe/Stockholm";

  environment.sessionVariables = {
    EDITOR = "lvim";
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
      ];
    })
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true; 
  networking.hostName = "nixos"
  console.keyMap = "sv-latin1";
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      bjorn = {
        initialPassword = "password";
        isNormalUser = true;
        description = "Björn Tenje Persson";
        extraGroups = [
          "wheel"
          "audio"
          "networkmanager"
        ];
      }
    }
  }
  
  services = {
    openssh = {
      enable = true;
    };
    xserver = {
      enable = true;
      layout = "se";
      xkbVariant = "";
      displayManager = {
        sddm.enable = true;
      };
      windowManager = {
        i3.enable = true;
      };
    };
  };
};
