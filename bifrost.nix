{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

with pkgs; [
  hello
  firefox
  discord
  steam
  vlc
  pinta
  eog
  flatpak
  libreoffice
  supertuxkart
  proton-vpn
  glib
  glibcLocales
  fontconfig
  noto-fonts
  xdg-utils
  gnome-tweaks
  ptyxis
  chromium
]
