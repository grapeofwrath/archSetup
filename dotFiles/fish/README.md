Install fish
```bash
sudo pacman -S fish
```

Set as default shell
```
chsh -s /usr/bin/fish
```

Restart terminal

Remove default greeting
```fish
set -U fish_greeting
```

Add thefuck and reset shell
```fish
echo "thefuck --alias | source" > ~/.config/fish/config.fish
fish
```

Use `fish_config` to access web interactive config
