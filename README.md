[![Coverage Status](https://coveralls.io/repos/github/jo-quin/battle_ship/badge.svg?branch=master)](https://coveralls.io/github/jo-quin/battle_ship?branch=master)   [![Build Status](https://travis-ci.com/jo-quin/battle_ship.svg?branch=master)](https://travis-ci.com/jo-quin/battle_ship)

# Battle_ship

An online CLI BattleShip game.

My main motivation to create this CLI replica of the BattleShip game was to learn how to connect different users on different networks to play against each other online. The app is hosted on a Raspberry Pi computer connected to the internet where users can connect to via Telnet.

## Usage

Git clone the repo and run `ruby lib/battle_ship.rb`. This will start the game server.

In another tab enter `nc localhost 2979`. This will connect to the local server.

Have fun! 🚢
