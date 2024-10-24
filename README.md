# Installing 
## Backup and remove old nvim config.
Backup old nvim config.
```
mv ~/.config/nvim ~/.config/nvim-old
```
Or remove old nvim config.
```
rm -rf ~/.config/nvim
```
Remove local/state and local/share
```
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
```
Install required packages Ubuntu/Debian
```
sudo pacman -S --needed unzip luarocks xclip wl-clipboard
```
Install required packages parrot.
```
sudo apt install unzip luarocks xclip wl-clipboard
```

Clone this repository.
```
git clone https://github.com/m4teoarg/nvim-java-py ~/.config/nvim && nvim
```

![Deja una estrella. Comparte.](https://github.com/m4teoarg/nvim-java-py/blob/master/java.png)
![Deja una estrella. Comparte.](https://github.com/m4teoarg/nvim-java-py/blob/master/readme.png)
