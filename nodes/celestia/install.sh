#!/bin/bash
#X-l1bra
clear && source <(curl -s https://raw.githubusercontent.com/plnine/x-l1bra/main/scripts/common.sh)


printLogo
printRed  =======================================================================
read -r -p "Enter node moniker:" NODE_MONIKER

printCyan "Please wait........" && sleep 1

printYellow "1. Update........" && sleep 1
#################################################
sudo apt update  > /dev/null 2>&1 && sudo apt upgrade -y  > /dev/null 2>&1
#################################################
printGreen "Updates uploaded." && sleep 1

printYellow "2.Installing packages........" && sleep 1
#################################################
sudo apt install -y make clang pkg-config libssl-dev build-essential git gcc lz4 chrony unzip curl jq ncdu htop net-tools lsof fail2ban wget -y > /dev/null 2>&1
#################################################
printGreen "Installation completed." && sleep 1

printYellow "3.Installing go........" && sleep 1
#################################################
source <(curl -s "https://raw.githubusercontent.com/nodejumper-org/cosmos-scripts/master/utils/go_install.sh") > /dev/null 2>&1
  source .bash_profile
go version
#################################################
printGreen "Completed."

printYellow "4.Download and install binary........"
#################################################
cd $HOME || return > /dev/null 2>&1
rm -rf celestia-app > /dev/null 2>&1
git clone https://github.com/celestiaorg/celestia-app.git > /dev/null 2>&1
cd celestia-app || return > /dev/null 2>&1
git checkout v0.11.0
make install > /dev/null 2>&1
celestia-appd version # 0.11.0
#################################################
printGreen "Completed."

printYellow "5.Set variables........" && sleep 1
#################################################
CHAIN_ID="mocha"
CHAIN_DENOM="utia"
BINARY_NAME="celestia-appd"
BINARY_VERSION_TAG="v0.11.0"
IDENTITY="8F3C23EC3306B513"
echo -e "Node moniker:       ${CYAN}$NODE_MONIKER${NC}"
echo -e "Chain id:           ${CYAN}$CHAIN_ID${NC}"
echo -e "Chain demon:        ${CYAN}$CHAIN_DENOM${NC}"
echo -e "Binary version tag: ${CYAN}$BINARY_VERSION_TAG${NC}"
echo -e "IDENTITY:	     ${CYAN}$IDENTITY${NC}"
#################################################
printGreen "Completed." && sleep 1

printYellow "6.Initialize the node........" && sleep 1
#################################################
celestia-appd config keyring-backend test > /dev/null 2>&1
celestia-appd config chain-id $CHAIN_ID > /dev/null 2>&1
celestia-appd init "$NODE_MONIKER" --chain-id $CHAIN_ID > /dev/null 2>&1

curl -s https://raw.githubusercontent.com/celestiaorg/networks/master/mocha/genesis.json > $HOME/.celestia-app/config/genesis.json > /dev/null 2>&1
curl -s https://snapshots3-testnet.nodejumper.io/celestia-testnet/addrbook.json > $HOME/.celestia-app/config/addrbook.json > /dev/null 2>&1
#################################################
printGreen "Completed." && sleep 1

printYellow "7.Adding seeds and peers........" && sleep 1
#################################################
SEEDS=$(curl -sL https://raw.githubusercontent.com/celestiaorg/networks/master/mocha/seeds.txt | tr -d '\n') > /dev/null 2>&1
PEERS=$(curl -sL https://raw.githubusercontent.com/celestiaorg/networks/master/mocha/peers.txt | tr -d '\n') > /dev/null 2>&1
sed -i 's|^seeds *=.*|seeds = "'$SEEDS'"|; s|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.celestia-app/config/config.toml > /dev/null 2>&1
#################################################
printGreen "Completed." && sleep 1


printYellow "8.Setting up pruning........" && sleep 1
#################################################
PRUNING_INTERVAL=$(shuf -n1 -e 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97) > /dev/null 2>&1
sed -i 's|^pruning *=.*|pruning = "custom"|g' $HOME/.celestia-app/config/app.toml > /dev/null 2>&1
sed -i 's|^pruning-keep-recent  *=.*|pruning-keep-recent = "100"|g' $HOME/.celestia-app/config/app.toml > /dev/null 2>&1
sed -i 's|^pruning-interval *=.*|pruning-interval = "'$PRUNING_INTERVAL'"|g' $HOME/.celestia-app/config/app.toml > /dev/null 2>&1
sed -i 's|^snapshot-interval *=.*|snapshot-interval = 2000|g' $HOME/.celestia-app/config/app.toml > /dev/null 2>&1
sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.0001utia"|g' $HOME/.celestia-app/config/app.toml > /dev/null 2>&1
sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/.celestia-app/config/config.toml > /dev/null 2>&1
#################################################
printGreen "Completed." && sleep 1


printYellow "9.Create a service file........" && sleep 1
#################################################
sudo tee /etc/systemd/system/celestia-appd.service > /dev/null << EOF
[Unit]
Description=Celestia Validator Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which celestia-appd) start
Restart=on-failure
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF
#################################################
printGreen "Completed." && sleep 1

celestia-appd tendermint unsafe-reset-all --home $HOME/.celestia-app --keep-addr-book > /dev/null 2>&1

SNAP_NAME=$(curl -s https://snapshots3-testnet.nodejumper.io/celestia-testnet/ | egrep -o ">mocha.*\.tar.lz4" | tr -d ">")

printYellow "9.Download snapshots........" && sleep 1
#################################################
curl https://snapshots3-testnet.nodejumper.io/celestia-testnet/${SNAP_NAME} | lz4 -dc - | tar -xf - -C $HOME/.celestia-app
#################################################
printGreen "Completed." && sleep 1

sudo systemctl daemon-reload
sudo systemctl enable celestia-appd
sudo systemctl start celestia-appd


printGreen "Installation completed" && sleep 1

printRed  =============================================================================== 
echo -e "Check logs:                ${CYAN} sudo journalctl -u celestia-appd -f --no-hostname -o cat ${NC}"
echo -e "Check synchronization:     ${CYAN} celestia-appd status 2>&1 | jq .SyncInfo.catching_up${NC}"
echo -e "Add New Wallet:            ${CYAN} celestia-appd keys add wallet${NC}"
echo -e "Recover Existing Wallet:   ${CYAN} celestia-appd keys add wallet --recover${NC}"
echo -e "X-l1bra:   		    ${CYAN} https://t.me/xl1bra${NC}"
printRed  =============================================================================== 