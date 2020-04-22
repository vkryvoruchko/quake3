
![Quake 3](https://raw.githubusercontent.com/vkryvoruchko/quake3/master/logo.jpg)


### Quake III Arena linux dedicated server HOWTO
##### Create the server config file

Step 4 : Create the server config file

create a quake 3 config file that your server will use.

an example config file for a Quake 3 Server that runs the OSP mod and uses a Maprotate file called "maprotation-osp.cfg" is given below :
```
// ********************** START OF Q3A SERVER FILE **********************
// FILENAME : q3ded-osp.cfg


// q3a server config
// vq3 ffa
// make sure the map rotation file 'maprotate-osp-ffa.cfg' exists
// written by spirit, based on the config from holarse.net


// --- contact and admin ---
sets ".Admin"  "change_me"			// admin name
sets ".email" "change_me"			// admin email
sets ".www"   "change_me"		        // www site that offers maps rotated on the server etc


// --- basic stuff ---
seta rconPassword "change_me"           	// remote console admin password
seta g_gametype "0"				// gametype (0 = ffa, 1 = tourney,  2 = ffa, 3 = tdm, 4 = ctf)


// --- banner stuff ---
seta sv_hostname "change_me"		        // how the server shows up in q3a game browser
seta g_motd "change_me"		                // message of the day, shown on client connect


// --- misc ---
seta r_smp "0"					// whether the server has multiple CPUs
seta sv_pure "1"				// whether .pk3-files are cheat checked


// --- clients and slots ---
g_password "change_me"		        	// server password for clients who try to connect
g_needpass "0"					// whether the password is enabled / needed to connect
seta sv_maxClients "8"				// max players allowed on server, includes spectators
seta sv_privateClients "2"			// reserved slots for players who know the private password
seta sv_privatePassword "change_me" 		// private slot password
seta g_syncronousClients "0"			// whether clients are allowed to record demos
seta g_allowvote "0"				// map - map restart - kick - g_gametype


// --- annoyances ---
// Note that you need to turn punkbuster off on the command line when you start the server (q3ded +set sv_punkbuster 0 ...)
// because you can't change the setting anymore once the server process has started! Removing the next line (or putting 'sv_punkbuster 0'
// into your config file will NOT turn off punkbuster.
pb_sv_enable					// enable punkbuster server
pb_sv_guidrelax 7				// disable punkbuster CD-check
seta sv_strictauth "0"				// whether CD-key is checked on client


// --- network ---
seta sv_allowdownload "0"			// whether clients are allowed to d/l maps etc from server
seta sv_maxRate "10000" 			// download speed limit
seta sv_floodProtect "1" 			// whether server uses flood-protection
seta sv_master1 "master0.gamespy.com:28900"     // master servers where the server registers itself
seta sv_master2 "master.gamershut.de:27950" 	//   to be found by players.
seta sv_master3 "master.gnw.de:27950"		//   use +set dedicated x to tell the server whether or not
seta sv_master4 "master3.idsoftware.com:27950"  //   to register itself there, x = 2 : register x = 1 : don't


// --- weapons ---
seta g_quadfactor "3"				// quad damage multiplier, default = 3
seta g_weaponrespawn "5" 			// weapon respawn time in secs, default = 5
seta g_friendlyfire "0"				// whether you can do damage to your team members
seta g_teamAutoJoin "0"				// whether players are automatically added to a team
seta g_teamForceBalance "0"			// whether teams are auto-balanced by the server
seta g_forcerespawn "2"				// time after which players are forced to respawn, 0 = never


// --- movement ---
seta pmove_fixed "1"				// whether movement is independent of client framerate
seta pmove_msec "16" 				// dont ask me
seta sv_fps "30"				// server frame rate


// --- bots ---
seta bot_enable "1"				// whether bots are allowed on the server
seta bot_minplayers "0" 			// minimum players number, filled up with bots if fewer
seta bot_nochat "1"				// whether bots are allowed to chat


// --- map rotation ---
exec maprotation-osp.cfg


// ********************** END OF Q3A SERVER FILE **********************
```



Step 5 : Create the server maprotation file

create a quake 3 server maprotation file that your server will use.

an example maprotation file that rotates some maps from the OSP mod is given below :
```
// ********************** START OF Q3A MAPROTATION FILE **********************
// FILENAME : maprotation-osp.cfg


// map-rotation for q3a osp free for all (ffa)
// gametypes : 0 = ffa, 1 = tourney,  2 = ffa, 3 = tdm, 4 = ctf

set m1 "fraglimit 50; timelimit 0 ; g_gametype 0 ; map ospdm12 ; set nextmap vstr m2"
set m2 "fraglimit 50; timelimit 0 ; g_gametype 0 ; map ospdm8 ; set nextmap vstr m3"
set m3 "fraglimit 50; timelimit 0 ; g_gametype 0 ; map ospdm9 ; set nextmap vstr m4"
set m4 "fraglimit 50; timelimit 0 ; g_gametype 0 ; map ospdm6 ; set nextmap vstr m5"
set m5 "fraglimit 50; timelimit 0 ; g_gametype 0 ; map ospdm5 ; set nextmap vstr m6"
set m6 "fraglimit 50; timelimit 0 ; g_gametype 0 ; map ospdm4 ; set nextmap vstr m1"
vstr m1


// ********************** END OF Q3A MAPROTATION FILE **********************

```


Step 6 : Create a shellscript to start the server

we'll use the unix program 'screen' in this script, so again make sure you have installed it.

an example startup script that runs the osp mod is given below. simply omit the '+set fs_game osp' if you want a vanilla q3a server (no mods) and set your servers IP, port and any name you want to identify the server.

some notes on adapting the script to your needs:

* choose a port > 1024. ports in the range 27960 - 27963 are recommended because servers using these ports are listed in the quake in-game server browser.

* using '+set dedicated 2' instead of '+set dedicated 1' will register your server with the masterservers you configured in the server config file. this will quickly fill the server with players.

* you can easily start multiple q3a servers (one running osp, one running rocket arena,...) if you set a different port for each of the servers.
```
// ********************** START OF SHELLSCRIPT TO START THE SERVER **********************
// FILENAME : start-osp-server.sh


#!/bin/sh
ip="ip_of_your_server"
port="port_of_your_server"
name="q3a-osp"

echo running server $name on $ip : $port

screen -A -m -d -S $name /usr/local/games/quake3/q3ded +set sv_punkbuster 1 +set fs_basepath /usr/local/games/quake3/ +set fs_game osp +set dedicated 1 +set com_hunkMegs 32 +set net_ip $ip +set net_port $port +set g_log $name.log +exec q3ded-osp-ffa.cfg


// ********************** END OF SHELLSCRIPT TO START THE SERVER **********************
```
so what does that script do? it uses screen (a unix screen manager, see 'man screen') to run the quake server in a detached screen session named "q3a-osp". this is needed to keep the quake server running when you disconnect from the remote host.

because q3ded is not a daemon process, it is attached to your terminal session and your q3a server would go down if you didn't use screen and quit the shell (type 'exit' or 'logout' in ssh/bash). this isn't what we want, so we use screen.

the name of the screen session can be used to bring the server back to your terminal by logging in via ssh or whatever and restoring the detached screen session of the server by typing

quake3@myserver> $ screen -r sessionname
to see the list of screen session for the current user, type

quake3@myserver> $ screen -list
