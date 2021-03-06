echo "Let's get some stuff set up! First, we'll ask for your administrator password up front so we can install all the things we need to."

# Ask for the administrator password upfront.
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

echo "Installing homebridge..."
echo "..."

sudo curl -sL https://deb.nodesource.com/setup_12.x | bash -
sudo apt-get install -y nodejs gcc g++ make python

# test node is working
sudo node -v

sudo npm install -g --unsafe-perm homebridge@latest homebridge-config-ui-x@latest

sudo useradd -m --system homebridge
sudo echo 'homebridge    ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo
sudo mkdir -p /var/lib/homebridge

echo "Creating default homebridge config..."
echo "..."

sudo cat >/var/lib/homebridge/config.json <<EOL
{
    "bridge": {
        "name": "Homebridge",
        "username": "CB:22:3D:E2:CE:31",
        "port": 51826,
        "pin": "033-44-254"
    },
    "accessories": [],
    "platforms": [
        {
            "name": "Config",
            "port": 8080,
            "standalone": true,
            "auth": "form",
            "theme": "teal",
            "restart": "sudo -n systemctl restart homebridge",
            "tempUnits": "c",
            "sudo": true,
            "log": {
                "method": "systemd"
            },
            "platform": "config"
        }
    ]
}
EOL

echo "Setting up homebridge and config-ui-x services..."
echo "..."

sudo cat >/etc/systemd/system/homebridge.service <<EOL
[Unit]
Description=Homebridge
After=syslog.target network-online.target

[Service]
Type=simple
User=homebridge
EnvironmentFile=/etc/default/homebridge
ExecStart=$(which homebridge) \$HOMEBRIDGE_OPTS
Restart=on-failure
RestartSec=3
KillMode=process
CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_CHOWN CAP_FOWNER CAP_DAC_OVERRIDE CAP_AUDIT_WRITE CAP_SYS_ADMIN
AmbientCapabilities=CAP_NET_RAW

[Install]
WantedBy=multi-user.target
EOL

sudo cat >/etc/default/homebridge <<EOL
# Defaults / Configuration options for homebridge
# The following settings tells homebridge where to find the config.json file and where to persist the data (i.e. pairing and others)
HOMEBRIDGE_OPTS=-U /var/lib/homebridge -I

# If you uncomment the following line, homebridge will log more
# You can display this via systemd's journalctl: journalctl -f -u homebridge
# DEBUG=*

# To enable web terminals via homebridge-config-ui-x uncomment the following line
# HOMEBRIDGE_CONFIG_UI_TERMINAL=1
EOL

sudo cat >/etc/systemd/system/homebridge-config-ui-x.service <<EOL
[Unit]
Description=Homebridge Config UI X
After=syslog.target network-online.target

[Service]
Type=simple
User=homebridge
EnvironmentFile=/etc/default/homebridge
ExecStart=$(which homebridge-config-ui-x) \$HOMEBRIDGE_OPTS
Restart=on-failure
RestartSec=3
KillMode=process
CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_CHOWN CAP_FOWNER CAP_DAC_OVERRIDE CAP_AUDIT_WRITE CAP_SYS_ADMIN
AmbientCapabilities=CAP_NET_RAW

[Install]
WantedBy=multi-user.target
EOL

echo "Installing homebridge plugins..."
echo "..."

sudo npm -g i homebridge-hue
sudo npm -g i homebridge-script2

#COPY YOUR CONFIG NOW if you're gonna

read -p "Do you have a homebridge directory to copy over? If so, please move it to /home/pi/homebridge before choosing Yes or No." choice
case "$choice" in
y | Y)
    echo "Setting up your copied configuration files"
    sudo rm -r /var/lib/homebridge
    sudo mv /home/pi/homebridge /var/lib/
    ;;
n | N) echo "Skipping..." ;;
*) echo "invalid" ;;
esac

sudo chown -R homebridge: /var/lib/homebridge

echo "Installing Arlo python library. Assuming you put your scripts in /var/lib/homebridge/white-button?"

sudo chmod +x /var/lib/homebridge/white-button/*.sh
sudo apt-get install python-pip -y
sudo pip install arlo

sudo systemctl daemon-reload
sudo systemctl enable homebridge
sudo systemctl start homebridge
sudo systemctl enable homebridge-config-ui-x
sudo systemctl start homebridge-config-ui-x

sudo apt-get install openjdk-8-jdk openjdk-8-jre -y

mkdir filebot-portable && cd filebot-portable
sh -xu <<<"$(curl -fsSL https://raw.githubusercontent.com/filebot/plugins/master/installer/tar.sh)"

read -p "Download your filebot license from your email to ~/ and rename to 'filebot.psm'.
Press [Enter] to continue."
echo ""

filebot --license ~/filebot.psm

read -p "Next, get your rclone putio access_token from your email and enter it here without quotes: " rclone_token
echo "Installing rclone..."
echo ""
curl https://rclone.org/install.sh | sudo bash
mkdir ~/.config/
mkdir ~/.config/rclone/
touch ~/.config/rclone/rclone.conf
echo '\n[putio]\ntype = putio\ntoken = {"access_token":"'$rclone_token'","expiry":"0001-01-01T00:00:00Z"}' >~/.config/rclone/rclone.conf

echo "Adding rclone and filebot aliases to .zshrc..."
echo ""

echo 'alias putmount="rclone mount putio: ~/mount/putio --daemon"' >>~/.zshrc
echo 'alias putrename="filebot -script fn:amc --output ~/mount/putio -non-strict --def clean=y subtitles=en --conflict auto ~/mount/putio/_To\ Rename"' >>~/.zshrc
echo 'alias putrenameorson="filebot -script fn:amc --output ~/mount/putio/Orson -non-strict --def clean=y --conflict auto ~/mount/putio/Orson/_Parse"' >>~/.zshrc

source ~/.zshrc

mkdir ~/mount
mkdir ~/mount/putio
putmount
