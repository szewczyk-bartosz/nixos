# Installation:

## 1. Get nixos
Get yourself a nixOS iso:
https://nixos.org/download/

## 2. Preparation
Boot it up, create your partition scheme, format the partitions and mount them

## 3. Generating config
Generate the config and assuming you mounted your main storage partition at /mnt

`nixos-generate-config --root /mnt`

## 4. Edit config

Look at example-config.nix for an example

Edit in your hostname

Uncomment network manager so you get internet

Include git so you can download this config once you boot in

Put in your username

Enable flakes and nix command and the bottom of the file 


Honestly can just copy the same thing altough the above are the only important things


## 5. Install system
`nixos-install --root /mnt`

## 6. Reboot
`reboot`

You get the idea


## 7. Cloning this git repo

`git clone https://github.com/szewczyk-bartosz/nixos.git`

Remove the git repo part of this
`cd nixos`
`rm -rf .git`


## 8. Next steps

I will write a guide to add your own computer but for now you can just use my laptop setup out of the box

## 9. Copy your hardware config

`cp /etc/nixos/hardware-configuration.nix ~/nixos/hardware-configs/hardware-YOURHOSTNAME.nix`

## 10. Edit the config to fit your computer

Open the file k1v1-config.nix under system configs

Edit the networking.hostName attribute to your hostname

Edit your username in (same place as previously)

Edit the hardware-config chosen to your one

so instead of

`../hardware-configs/hardware-k1v1.nix`

do

`../hardware-configs/hardware-YOURHOSTNAME.nix`


## 11. Install home manager

`nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager`

`nix-channel --update`

`nix-shell '<home-manager>' -A install`

## 12. Finish installation

Now you just need to decide on the theme

i will go through the commands for the Arasaka theme

From within the nixos directory (the one you cloned):

`sudo nixos-rebuild switch --flake .#k1v1`

then

`home-manager switch --flake .#arasaka.k1v1`

Wait for the commands to finish then reboot and youre done!


# nixos
My nixOS configuration files

Currently in the ricing process, trying to create a nixOS setup that allows for multiple themes easily switched using home manager

Current theme list:
- Arasaka
- Mocha (catppuccin)
- Latte (catppuccin)


## Current focus:
More of a desktop experience, make sure the file manager works and that the theme is consistent across the system

Add some sort of a way to connect to wifi etc without nmcli on command line [Maybe?]

Volume popup when changing volume

Waybar animations

Icons for the catppuccin themes

Terminal multiplexer

Secure boot

Better screenshots

Waybar improvements




## Todos:
- [x] Basic, but aesthetic waybar
- [x] Cursor changed
- [x] Terminal theme
- [x] Neovim setup for development (swapped to helix)
- [x] Direnv set up (but not part of this repo)
- [ ] Finish configuring hyprland and move to a nix based hyprland configuration instead of a string
- [ ] Add more robust screenshots
- [ ] Secure boot support
- [ ] Consider a terminal multiplexer





Credits:

When customising my waybar I heavily relied on the mechabar preset made by the github user "sejjy", parts of the code are copied from that repo, all credit to them for the bar. Link to the repo below:
https://github.com/sejjy/mechabar

Kitty Catppucin themes:
https://github.com/catppuccin/kitty
