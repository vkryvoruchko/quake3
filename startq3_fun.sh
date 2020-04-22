#!/usr/bin/env bash
docker stop quake3 && docker rm quake3
wanip=$(dig @resolver1.opendns.com ANY myip.opendns.com +short)
docker run --name=quake3 -d -v /home/${USER}/quake3/pak0.pk3:/usr/share/games/quake3/baseq3/pak0.pk3 -v /home/${USER}/quake3/server_fun.cfg:/usr/share/games/quake3/baseq3/server.cfg -p 27960:27960/udp vkryvoruchko/quake3
#docker run --name=quake3 -d -v /home/${USER}/quake3/pak0.pk3:/usr/share/games/quake3/baseq3/pak0.pk3 -p 27960:27960/udp vkryvoruchko/quake3
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
