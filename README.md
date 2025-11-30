# Home

* Install [nix](https://nixos.org/download.html)
```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

* Run the bootstrap script
```sh
nix run github:RasmusKB/home?dir=home-manager#bootstrap --extra-experimental-features "nix-command flakes"
```
