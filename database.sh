#! /bin/bash

#varible that allows changes to postres database
PSQL_database="psql --username=freecodecamp --dbname=postgres -t --no-align -c"

#varible that checks existance of worldcup database
psql --username=freecodecamp --dbname=postgres -lqt | cut -d \| -f 1 | grep -qw worldcup
WORLDCUP_EXISTANCE=$?

#loop that checks existance of worldcup database and drops it if it exists
if [[ $WORLDCUP_EXISTANCE == 0 ]]
then
  echo $($PSQL_database "DROP DATABASE worldcup;")
fi

#creating new worldcup database
echo $($PSQL_database "CREATE DATABASE worldcup;")

#varible that allows changes to worldcup database
PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

#creating games and teams tables
echo $($PSQL "CREATE TABLE games(game_id SERIAL PRIMARY KEY NOT NULL, year INT NOT NULL, round VARCHAR(30) NOT NULL, winner_id INT NOT NULL, opponent_id INT NOT NULL, winner_goals INT NOT NULL, opponent_goals INT NOT NULL);")
echo $($PSQL "CREATE TABLE teams(team_id SERIAL PRIMARY KEY NOT NULL, name VARCHAR(30) UNIQUE NOT NULL);") 
echo $($PSQL "ALTER TABLE games ADD FOREIGN KEY (winner_id) REFERENCES teams(team_id), ADD FOREIGN KEY (opponent_id) REFERENCES teams(team_id);")
