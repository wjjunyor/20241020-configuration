# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

   # Install DroidCam and needed v4l2loopback
   #  let v4l2loopback-dc = config.boot.kernelPackages.callPackage ./v4l2loopback-dc.nix { };
   #      droidcam = pkgs.callPackage ./droidcam.nix {};
   #  in {
   #    boot.extraModulePackages = [ v4l2loopback-dc ];
   #     environment.systemPackages = [ droidcam ];
   #   }

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Enable the KDE Desktop Environment.
      ./users-configuration.nix
      ./local-configuration.nix
      ./wjjunyor-configuration.nix
      ./x-configuration.nix
      ./networking-configuration.nix
      # Sets-up the Home Manager
      # "${home-manager}/nixos"
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  # Uses the most recent packages.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amd_iommu=on" "iommu=1" "rd.driver.pre=vfio-pci" ];   #If host = T101 or T800
  boot.kernelModules = [ "kvm-amd" "tap" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" "v4l2loopback" "snd-aloop" "amdgpu" "dm-snapchot" ]; # "hid-nintendo" #If host = T101 or T800
  boot.extraModprobeConfig = ''#If host = T101 or T800 
	options vfio-pci ids=vendorid:deviceid,vendorid:deviceid 
	options v4l2loopback nr_devices=2 exclusive_caps=1,1,1,1,1,1,1,1 video_nr=0,1 card_label=v4l2lo0,v4l2lo1
        ''; 

  # Teste ZFS 
  # boot.initrd.supportedFilesystems = [ "zfs" ];
  # boot.supportedFilesystems = [ "zfs" ];
  # boot.zfs.enableUnstable = false;
  # services.zfs.autoScrub.enable = true;
  # services.zfs.autoSnapshot.enable = true;
  # services.zfs.autoSnapshot.frequent = 8;
  # services.zfs.autoSnapshot.monthly = 1;
  # services.zfs.trim.enable = true;

  # Supposedly better for the SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # boot.loader.grub.version = 2;     %%% DEPRECATED %%%
  # boot.loader.grub.backgroundColor = "#7EBAE4";
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Grub menu is painted really slowly on HiDPI, so we lower the
  # resolution. Unfortunately, scaling to 1280x720 (keeping aspect
  # ratio) doesn't seem to work, so we just pick another low one.
  boot.loader.grub.gfxmodeEfi = "1024x768";
  boot.loader.grub.enableCryptodisk = true;
  boot.initrd.luks.devices = {
    "root" = {
    device = "/dev/disk/by-uuid/209d5369-c671-4d18-adc2-a97e58c5bb69";
    preLVM = true;
    allowDiscards = true;
    };
  };
  
 
  # Select internationalisation properties.

  console.earlySetup = true;
  console.font = "Lat2-Terminus16";   
  console.keyMap = "br-abnt2";
  i18n.defaultLocale = "pt_BR.UTF-8";
  # i18n.supportedLocales = [
  #   "all"
  #   "pt_BR.UTF-8/UTF-8"
  #   "en_GB.UTF-8/UTF-8"
  #   "es_ES.UTF-8/UTF-8"
  #   "fr_FR.UTF-8/UTF-8"
  #   "zh_CN.UTF-8/UTF-8"
  #   "C.UTF-8/UTF-8"
  # ];
  # i18n.extraLocaleSettings = {
  #   LANGUAGE = "pt_BR";
  #   LC_ALL = "";
  #   LC_ADDRESS = "pt_BR.UTF-8";
  #   LC_IDENTIFICATION = "pt_BR.UTF-8";
  #   LC_MEASUREMENT = "pt_BR.UTF-8";
  #   LC_MONETARY = "pt_BR.UTF-8";
  #   LC_NAME = "pt_BR.UTF-8";
  #   LC_NUMERIC = "pt_BR.UTF-8";
  #   LC_PAPER = "pt_BR.UTF-8";
  #   LC_TELEPHONE = "pt_BR.UTF-8";
  #   LC_TIME = "pt_BR.UTF-8";  
  # };
  i18n.inputMethod.fcitx5.plasma6Support = true;
 
  # Set your time zone.
  time.timeZone = "America/Campo_Grande";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.bash.enableCompletion = true;
  programs.nix-index.enableBashIntegration = true;
  programs.zsh.enableBashCompletion = true;
  
  # List services that you want to enable:

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Team Viewer Listener
  services.teamviewer.enable = false;

  # Teste Hardware ZFS 
  # HARDWARE
  hardware.bluetooth.enable = true;
  hardware.cpu.amd.updateMicrocode = true;
  # hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiVdpau libvdpau-va-gl ];
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.zeroconf.discovery.enable = true;
  hardware.pulseaudio.zeroconf.publish.enable = true;
  hardware.sane.enable = true;

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  powerManagement.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "24.05"; # Did you read the comment?
  
  # Auto upgrade Always ON.
  system.autoUpgrade.enable = true;

  # Garbage Collection Automation and Disk Usage Otimization
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";
  nix.settings.auto-optimise-store = true;
  nix.extraOptions = ''
    min-free = ${toString (100 * 1024 * 1024)}
    max-free = ${toString (1024 * 1024 * 1024)}
  '';
  services.journald.extraConfig = ''
    SystemMaxUse=2G
  '';

  # Fundamental core packages
  environment.systemPackages = with pkgs; 
   [ # Basic command line tools
     bash
     zsh
     wget
     file
     # gksu
     glibcLocalesUtf8
     git
     hdf5
     zip
     unzip
     htop
     yle-dl
     youtube-dl
     # Tool for searching files/binaries from Nix packages
     nix-index
     dnsutils
     whois
     coreutils
     vbetool
     killall
     nethogs
     unrar
     # Gamin: a file and directory monitoring system
     # fam - DEPRECATED
     # Basic image manipulation and handling stuff
     imagemagick
     ghostscript
     # Text editors
     vim
     # system clipboard support for vim
     xclip
     # VPN
     pptp
     openvpn
     # File format conversions
     pandoc
     pdf2svg
     # Screen brightness and temperature
     redshift
     # SSH filesystem
     sshfs-fuse
     # Yet another dotfile manager
     yadm
     # Password hash generator
     mkpasswd
     # Android
     jmtpfs
     gphoto2
     libmtp
     mtpfs
     nix-prefetch-git
     # Make NTFS filesystems (e.g., USB drives)
     ntfs3g
     # GUI for sound control
     pavucontrol
     # Bluetooth Support
     bluez
     # bluezFull # 20230213 Deprecated
     bluez-tools
     # Precisamos dele 
     pinentry-qt
     fontconfig
     glibcLocales
   ];
}
