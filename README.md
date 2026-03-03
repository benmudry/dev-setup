From scratch:
```
sudo dnf -y update
sudo dnf -y install git
mkdir $HOME/personal
mkdir $HOME/.config
mkdir -p ~/.local/bin
mkdir -p ~/.local/scripts
git clone git@github.com:benmudry/dev-setup.git $HOME/personal/dev-setup
cd $HOME/personal/dev-setup

./init
./setup.sh
```
