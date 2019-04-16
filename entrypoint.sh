#!/bin/bash
set -e
cd hlds
./hlds_run -game cstrike +hostname "$hostname" +sv_password "$password" +rcon_password "$rcon_password" +map de_dust2 -maxplayers "$maxplayer"  -port "$port"
