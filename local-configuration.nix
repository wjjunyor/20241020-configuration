{ config, lib, options, modulesPath, users, pkgs, environment, ... }: 
{
  # Specific packages for graphic environment for this station
  environment.systemPackages = with pkgs;
   [ # E-books
     # calibre
     # PDF Merge
     #pdfsam-basic
     # RSS reader
     # Disk usage analysis
     filelight
     qdirstat
     w_scan
     # Photo manager
     shotwell
     # Audio editor
     audacity
     # MPD client
     # cantata
     # Mobile device connect 
     kdeconnect
    ];
}
