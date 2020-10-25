Install fish
```bash
sudo pacman -S fish
```

Set as default shell
```
chsh -s /usr/bin/fish
echo /usr/local/bin/fish | sudo tee -a /etc/shells
set -U fish_user_paths /usr/local/bin $fish_user_paths
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
