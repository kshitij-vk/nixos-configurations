<h1 align="center">
 <img src="https://user-images.githubusercontent.com/45159366/128645103-795eebbd-f853-47cc-8087-916dfd98347b.png">
  <br />
   NixOS Guide
</h1>

<a href="https://github.com/kshitij-vk?tab=followers">
         <img alt="followers" title="Follow for Updates" src="https://custom-icon-badges.demolab.com/github/followers/kshitij-vk?color=236ad3&labelColor=1155ba&style=for-the-badge&logo=person-add&label=Follow&logoColor=white"/></a> 

![Maintenance](https://img.shields.io/maintenance/yes/2025?style=for-the-badge)
![Last-Commit](https://img.shields.io/github/last-commit/kshitij-vk/nixos-configurations?style=for-the-badge)

# Nixos-configurations

Open up your Documents folder and open a terminal there and type:

```bash
nix-env -i git 

```
This will install git. It might take a while to install it. Be patient.

Then you get this github project via this command in the same terminal:

```bash
git clone https://github.com/kshitij-vk/nixos-configurations ~/Programs/nixos-configurations
cd ~/Programs/nixos-configurations
sudo nixos-rebuild switch --flake ~/Programs/nixos-configurations/nixos#runtime --impure --show-trace
```

```bash
git clone https://github.com/Jas-SinghFSU/HyprPanel ~/Programs/HyprPanel
cd ~/Programs/HyprPanel/
nix build .
nix profile install .
```

Upgrade System
```bash
sudo nix flake update
sudo nixos-rebuild switch --flake ~/Programs/nixos-configurations/nixos#runtime --impure --show-trace --upgrade
```

Rebuild System
```bash
sudo nixos-rebuild switch --flake ~/Programs/nixos-configurations/nixos#runtime --impure --show-trace
```

# Desktops

 - gnome(Base for apps + Services)

 - hyprland
