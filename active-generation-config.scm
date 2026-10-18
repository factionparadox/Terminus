;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
	     (nongnu packages linux)
	     (nongnu system linux-initrd))
(use-service-modules cups desktop networking ssh xorg nix base pm linux)

(load "/etc/terminus/serialised-packages.scm")

(operating-system
  (locale "en_GB.utf8")
  (timezone "Europe/London")
  (keyboard-layout (keyboard-layout "gb"))
  (host-name "terminus-station")
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "lazar")
                  (comment "Stephen")
                  (group "users")
                  (home-directory "/home/lazar")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
(packages
 (append
  terminus-serialised-packages
  %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append
    (list
     (service gnome-desktop-service-type)
     (service nix-service-type)
     (service power-profiles-daemon-service-type)
     (service iio-sensor-proxy-service-type)
     (service fstrim-service-type)
     (service openssh-service-type)
     (service cups-service-type)
     (set-xorg-configuration
      (xorg-configuration
       (keyboard-layout keyboard-layout))))
    (modify-services %desktop-services
      (guix-service-type config =>
        (guix-configuration
         (inherit config)
         (substitute-urls
          (append
           (list "https://substitutes.nonguix.org")
           %default-substitute-urls))
         (authorized-keys
          (append
           (list (local-file "/etc/terminus/nonguix-signing-key.pub"))
           %default-authorized-guix-keys)))))))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "eb6e6cb0-4bf5-424e-bf91-3dd894d31140")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "3264-3B55"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "d31819c7-5348-4b1c-b9a1-aa3fb627be15"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
