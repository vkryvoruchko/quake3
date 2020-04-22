
![Quake 3](https://raw.githubusercontent.com/vkryvoruchko/quake3/master/logo.jpg)


### Quake 3 Server Launching

##### The `server.cfg` way

There is an included `docker-compose.yml` that shows the best way to launch this container and how to take care of the core dependencies: the retail `pak0.pk3`, the port forward for `27960/udp`, and optionally, your own `server.cfg`.

> Note that the server.cfg must exist in the `/usr/share/games/quake3/baseq3` directory! Added my custom.

If you decide to build and incorporate your own `server.cfg`, as is recommended, make sure you modify the `image` source or just use `build: .` in your `docker-compose.yml` :)

```
cd Quakefolder
git clone https://github.com/vkryvoruchko/quake3.git
cd quake3
edit volumes in docker-compose.yml to pint to existing one with `pak0.pk3` and optionally server.cfg
docker-compose up -d
...
docker-compose stop
```

##### The command way

You can also pass in configuration options via passing them as docker commands either on the command line or in your `docker-compose.yml`. 

```
docker run --name=quake3 -d -v /home/${USER}/quake3/pak0.pk3:/usr/share/games/quake3/baseq3/pak0.pk3 -v /home/${USER}/quake3/server.cfg:/usr/share/games/quake3/baseq3/server.cfg -p 27960:27960/udp vkryvoruchko/quake3
```

or 

```
docker run --name=quake3 -d -v /home/${USER}/quake3/pak0.pk3:/usr/share/games/quake3/baseq3/pak0.pk3 -p 27960:27960/udp vkryvoruchko/quake3
```

A comprehensive list of possibilities can be found [here](http://www.joz3d.net/html/q3console.html).

main commands:
```
\set rconpassword k8s
\rcon fraglimit 10000
\rcon map q3tourney4
\rcon g_spskill 5 --> bots level
\rcon bot_enable 1
\rcon addbot anarki 5 --> anarki,angel,biker,bitterman,bones,crash,daemia,doom,gorre,grunt,hossman,hunter,keel,klesk,lucy,major,mynx,orbb,patriot,phobos,ranger,razor,sarge,slash,sorlag,stripe,uriel,visor,wrack,xaero
\rcon bot_minplayers 10
\rcon bot_minplayers 1 --> remove bots
\rcon map_restart
\rcon status
\rcon nextmap
\rcon vstr d2 - change to second map in my rotation
\rcon kick all
\rcon kick allbots
\rcon kick 0
\team s --> spectator mode. s=spectator, p=player
```

startq3.sh
```
#!/usr/bin/env bash
docker stop quake3 && docker rm quake3
wanip=$(dig @resolver1.opendns.com ANY myip.opendns.com +short)
#docker run --name=quake3 -d -v /home/${USER}/quake3/pak0.pk3:/usr/share/games/quake3/baseq3/pak0.pk3 -v /home/${USER}/quake3/server.cfg:/usr/share/games/quake3/baseq3/server.cfg -p 27960:27960/udp vkryvoruchko/quake3
docker run --name=quake3 -d -v /home/${USER}/quake3/pak0.pk3:/usr/share/games/quake3/baseq3/pak0.pk3 -p 27960:27960/udp vkryvoruchko/quake3
sleep 3
docker logs quake3 --since=30s
echo "#########################################################################################################################################################"
docker container ls
echo "#########################################################################################################################################################"
echo "~~~~~~~~~~~~~~~~~~~~Server Connect~~~~~~~~~~~~~~~~~~~~"
echo "\connect ${wanip} or \connect ${wanip}:27960" 
echo "#########################################################################################################################################################"
echo "~~~~~~~~~~~~~~~~~~~~Common Commands~~~~~~~~~~~~~~~~~~~~"
echo "\set rconpassword k8s"
echo "\rcon fraglimit 10000"
echo "\rcon map q3tourney4"
echo "\rcon g_spskill 5 --> bots level"
echo "\rcon bot_enable 1"
echo "\rcon addbot anarki 5 --> anarki,angel,biker,bitterman,bones,crash,daemia,doom,gorre,grunt,hossman,hunter,keel,klesk,lucy,major,mynx,orbb,patriot,phobos,ranger,razor,sarge,slash,sorlag,stripe,uriel,visor,wrack,xaero"
echo "\rcon bot_minplayers 10"
echo "\rcon bot_minplayers 1 --> remove bots"
echo "\rcon map_restart"
echo "\rcon status"
echo "\rcon nextmap"
echo "\rcon vstr d2 - change to second map in my rotation"
echo "\rcon kick all"
echo "\rcon kick allbots"
echo "\rcon kick 0"
echo "\team s --> spectator mode. s=spectator, p=player"
```

#### Maps
Ideally, we like to cycle through maps, starting from the first. It would be even better if we could set random for all *minus* a few we don't like (q3dm19 is not favorable to my tastes). See my included example `server.cfg` for how I cycle through maps.

A great map breakdown can be seen [here](http://www.bosskey.net/q3a/maps/standard.html).

#### Bots

Please see [this](http://www.3dgw.com/guides/q3a/index.php3?page=configs.htm#serverbots) page for info on how to setup bots. 

Basically, you need `seta bot_enable 1` at the top of your config. After you define and start a map, you can then:

```
addbot anarki 5
addbot angel 5
addbot biker 5
addbot bitterman 5
addbot bones 5
addbot crash 5
addbot daemia 5
addbot doom 5
addbot gorre 5
addbot grunt 5
addbot hossman 5
addbot hunter 5
addbot keel 5
addbot klesk 5
addbot lucy 5
addbot major 5
addbot mynx 5
addbot orbb 5
addbot patriot 5
addbot phobos 5
addbot ranger 5
addbot razor 5
addbot sarge 5
addbot slash 5
addbot sorlag 5
addbot stripe 5
addbot uriel 5
addbot visor 5
addbot wrack 5
addbot xaero 5
```

> Bot names must be one of the supported character names! They **cannot** be custom!

#### GDOWN
I used gdown to download  pak0.pk3  from my google drive 
```
sudo apt-get update && sudo apt-get upgrade
sudo apt install  python3 python3-pip locate p7zip-full apt-transport-https ca-certificates curl software-properties-common mc ebtables ethtool docker.io vim -y
sudo usermod -aG docker ${USER}
sudo updatedb
pip3 install gdown
gdown https://drive.google.com/uc?id={$mygdiveid}
```

#### Troubleshooting

```
docker logs quake3
```

#### Linkage

Here are some really helpful links for setting up the `server.cfg` and utilizing rcon. 

http://it.rcmd.org/networks/q3_install/q3_linux_server_howto.php#step9

http://www.tldp.org/HOWTO/archived/Game-Server-HOWTO/quake3.html

http://gaming.stackexchange.com/questions/46735/quake-3-private-server-with-bots

http://notes.splitbrain.org/q3aserver

http://www.katsbits.com/articles/quake-3/add-remove-bots.php
