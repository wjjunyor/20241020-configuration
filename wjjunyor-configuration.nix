{ config, lib, options, modulesPath, users, pkgs, environment, ... }: 

{
  imports = [
    <nixos-hardware/lenovo/ideapad/s145-15api>
    ./hardware-configuration.nix
  ];

  
  # Allow GPU Driver for T-101 station.
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # Nix insecure packages allowance
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    "python-2.7.18.6"
    "python2.7-pyjwt-1.7.1"
    "python2.7-certifi-2021.10.8"
    "python2.7-Pillow-6.2.2"
    "python3.10-requests-2.28.2"
    "python3.10-cryptography-40.0.1"
    "python3.12-youtube-dl-2021.12.17"
    "python3.11-youtube-dl-2021.12.17"
    "adoptopenjdk-jre-openj9-bin-13.0.2"
    "libdwarf-20181024"
    "libtiff-4.0.3-opentoonz"
    "olm-3.2.16"
  ];

  # Nix daemon allowance for this user.
  nix.settings.allowed-users = [ "@wheel" "wjjunyor" ];

  # Specific services to be enabled for this user. 
  services.openssh.enable = true;
  services.tor.client.enable = true;
  services.tor.client.transparentProxy.enable =  true;
  services.blueman.enable = true;      # Estudar esta parada pois quero BT em meu note 

  # Battery improvement
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 75;
    STOP_CHARGE_THRESH_BAT0 = 80;
  };


  fileSystems."/W" =   { 
    device = "/dev/disk/by-uuid/7743a98e-9039-4df4-be37-a8626203bb96";
    fsType = "ext4";
    neededForBoot = true;
    options = [ "nofail" ];
  };
 
  fileSystems."/nix" =   { 
    device = "/W/N";
    neededForBoot = true;
    options = [ "noatime" "nofail" "bind"];
  };

  # Virtualization activation fos this user
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # virtualisation.virtualbox.guest.x11 = true;
  users.extraGroups.vboxusers.members = [ "wjjunyor" ];

  # Loads GPU drivers on T-101 station.
  # services.xserver.videoDrivers = [ "intel" "amdgpu" "amdgpu_pro" ];

  # Enable SmarCard Daemon.
  programs.gnupg.agent.enable = true;
  services.pcscd.enable = true; 
  services.pcscd.plugins =  with pkgs;
   [ acsccid                   # SmartCard Apps 
     ccid 
     # chrome-token-signing      # Chrome and Firefox extension for signing with your eID on the web
     cryptsetup                # Encrypted USB sticks etc
     eid-mw                    # Belgian electronic identity card (eID) middleware VAI QUE 
     encfs
     gnupg                     # Encryption key management
     gnupg-pkcs11-scd          # A smart-card daemon to enable the use of PKCS#11 tokens with GnuPG   
     gnupg1orig
     glibc                     # Para o WebSigner Certsign 
     # globalplatform            # Library for interacting with smart card devices                      # NOT WORKING
     # gpshell                   # Smartcard management application                                     # NOT WORKING
     libfx2                    # Chip support package for Cypress EZ-USB FX2 series microcontrollers
     libusb 
     libusb1 
     opensc                    # Set of libraries and utilities to access smart cards
     openct                    # Drivers for several smart card readers
     openssl 
     pcsctools 
     pcsc-cyberjack     
     pcsclite 
     pcmciaUtils               # PCMCIA Tools 
     pinentry                  # GPG password entry from the terminal
     usbutils
   ];
  
  # Steam joysticks
  hardware.steam-hardware.enable = true;
  
  # Specific programs for this user
  programs.adb.enable = true;
 
  # Specific hardware setings for this user
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.package = pkgs.bluez;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  # hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];
  
  # User fonts.   
  fonts.packages = with pkgs;
   [ font-awesome
     aileron
     ankacoder
     b612
     baekmuk-ttf
     cnstrokeorder
     comfortaa
     comic-neue
     crimson
     darktile
     encode-sans
     # euvypn-font
     eunomia
     f5_6
     font-awesome_4
     font-awesome
     gohufont
     # google-fonts
     # gubbi-font
     hanazono
     # helvetica-neue-lt-std
     hermit
     hyperscrypt-font
     ipaexfont
     luculent
     norwester-font
     noto-fonts
     overpass
     pecita
     penna
     # ricty
     roboto
     # source-sans-pro
     lbry
   ];

  # Specific packages for graphic environment for this user
  environment.systemPackages = with pkgs;
   [ # Wine for Windows Apps support both 32- and 64-bit applications
     # callPackage ./stremio.nix {}
     wineWowPackages.stable
     wineWowPackages.fonts
     winetricks
     # Drop-down terminal
     yakuake
     gimp-with-plugins #  Photo/Image Editor
     # Vector Editor 
     inkscape
     # ps2edit #For .eps file 
     # Painting Editor
     # krita
     # gmic-qt-krita
     libsForQt5.kdenlive
     # Layout and Publishing
     scribus
     # Torrenting
     ktorrent
     # Multimedia Central App 
     stremio
     # Camera App
     # kamoso
     # Browsers Suport 
     # firefox-wayland 
     # # firefox
     firefox-beta-bin
     # Instant messaging
     # cutegram
     tdesktop    #Telegram
     # element-web
     element-desktop
     #linphone
     #haskellPackage.signal
     signal-cli
     signal-desktop
     # Mobile device connect 
     kdeconnect
     # SU
     # kdesu
     # ZOOM Meeting - Tirar depois de usar essa coisa unsafe da porra
     zoom-us 
     # E-books
     # haskellPackages.gi-gdkpixbuf #For Adobe Reader
     # haskellPackages.gi-gdk_4_0_1 #For Adobe Reader
     # haskellPackages.gi-gdkx11    #For Adobe Reader
     # gdk-pixbuf                   #For Adobe Reader
     # rubyPackages.gdk_pixbuf2     #For Adobe Reader 
     # rubyPackages_2_5.gdk_pixbuf2 #For Adobe Reader
     # rubyPackages_2_7.gdk_pixbuf2 #For Adobe Reader
     # Browser
     tor                            # PARA PRODUÇÃO DEIXAR O TOR E OS FIREFOX SOMENTE PARA OS USUÁRIOS wjjunyor e caroles.melo
     tor-browser-bundle-bin         
     # RSS Reader
     rssguard
     # FTP Client
     filezilla
     # Password manager
     # keepass-keeagent
     # keepass-keepasshttp
     # keepass
     # Separate tiling window manager
     # i3
     patchelf
     # JOGOS DA QUARENTENA
     libGL
     # discord
     # minecraft
     # steam
     # Mobile SSH replacement
     mosh
     #Wireless 
     wirelesstools
     networkmanager
     # Bluetooth
     # bluedevil
     # Cosmos Application from Cardiff University requires JAVA
     jre
     jdk11 	 
     # jdk11_headless
     adoptopenjdk-icedtea-web
     # adoptopenjdk-bin
     temurin-bin
     # Painel de controle
     # linuxPackages.amdgpu-pro
     radeon-profile
     lm_sensors
     stress
     radeontop
     powerdevil
     google-cloud-sdk
     virtualbox
     neofetch
     xclip
     gephi
     t #Twitter command line client
     conda
     gitAndTools.gh
     # playonlinux
     # Wacom tools
     xf86_input_wacom
     wacomtablet
     libwacom
     # haskellPackages.wacom-daemon
     gptfdisk
     gparted
     parted
     zfs
     glib-networking
     # whatsapp-for-linux
     glib-networking
     anydesk   #Suporte Azul Seguros
     traceroute
     inetutils
     busybox
     drill
     # mongodb
     packetdrill
     anbox
     # Plasma Mobile Apps 
     # libsForQt5.plasma-dialer
     # libsForQt5.plasma-phonebook
     # libsForQt5.audiotube
     # libsForQt5.discover
     # libsForQt5.koko
     # libsForQt5.kalendar
     libsForQt5.kamoso
     libsForQt5.korganizer     
     libsForQt5.alligator
     libsForQt5.calindori
     libsForQt5.keysmith
     libsForQt5.neochat    
     libsForQt5.kmplot
     libsForQt5.kmail
     libsForQt5.kontact
     libsForQt5.akonadi
     libsForQt5.akonadi-mime
     libsForQt5.akonadi-notes
     libsForQt5.akonadi-search
     libsForQt5.akonadi-contacts
     libsForQt5.akonadi-calendar
     libsForQt5.akonadi-calendar-tools
     # kaidan
     # robotnix
     digikam
     # pixeluvo
     peruse
     exiftool
     darktable
     rawtherapee
     obs-studio #Broadcasting Studio
     obs-studio-plugins.wlrobs
     obs-studio-plugins.obs-nvfbc
     obs-studio-plugins.obs-vkcapture
     obs-studio-plugins.obs-gstreamer
     # obs-studio-plugins.obs-multi-rtmp
     obs-studio-plugins.obs-move-transition
     obs-studio-plugins.obs-pipewire-audio-capture
     obs-studio-plugins.looking-glass-obs
     # idrisPackages.canvas     
     anydesk
     rPackages.CoSMoS
     flutter
     dart
     android-tools
     # android-studio
     # androidStudioPackages.dev
     google-chrome
     clang
     cmake
     ninja
     pkg-config
     libgtkflow3
     libgtkflow4
     gtk3
     gtk3-x11
     haskellPackages.monad-control
     # haskellPackages.null-canvas
     # chickenPackages_5.chickenEggs.canvas-draw
     # haskellPackages.transformers-free
     # haskellPackages.linux-blkid
     # linuxPackages.hid-nintendo
     linuxPackages.v4l2loopback
     linuxPackages_5_10.v4l2loopback
     droidcam
     # nixops_unstable
     # nixops-dns
     # nixops_unstable
     nix-zsh-completions
     nix-bash-completions
     # glaxnimate # 2D Animation
     lmms       # Music Edition
     # natron     # VFX
     # opentoonz  # 2D Animation   #20231019 Error building
     python3Packages.magic-wormhole   
     python3
     # python38Packages.pip
     # python38Packages.tweepy
     # python39
     mediainfo
     mediainfo-gui
     libmediainfo
     # ####################### DEV
     elmPackages.elm
     waybar
     rpi-imager
     fwupd
     sound-theme-freedesktop
     kmymoney
   ];
  
}
