install
```bash
sudo pacman -S fish
```

set as default shell
```
chsh -s /usr/bin/fish
```

restart terminal

remove default greeting
```fish
set -U fish_greeting
```

add thefuck and reset shell
```fish
echo "thefuck --alias | source" > ~/.config/fish/config.fish
fish
```
