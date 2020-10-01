### Export / Import Gnome Terminal Theme

Export
```bash
$ dconf dump /org/gnome/terminal/legacy/profiles:/ > profile.dconf
```
Import
```bash
dconf load /org/gnome/terminal/legacy/profiles:/ < profile.dconf
```
