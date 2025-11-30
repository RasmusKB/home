# Home

* Create nix.conf (Workaround)
Create a file at `~/.config/nix/nix.conf` containing
```sh
experimental-features = nix-command flakes
```

* Install [nix](https://nixos.org/download.html)
```sh
sh <(wget -qO- https://nixos.org/nix/install) --daemon
```

* Run the bootstrap script
```sh
nix run github:RasmusKB/home#bootstrap --extra-experimental-features "nix-command flakes"
```
