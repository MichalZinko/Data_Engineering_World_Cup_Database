#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE TABLE games, teams;")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

  if [[ $WINNER != "winner" ]]
  then

    # get a team_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")

    #if not found
    if [[ -z $TEAM_ID ]]
    then

    # insert team
      INSERTING_TEAM_ID_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    fi

   # get new team
   TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
  fi

  if [[ $OPPONENT != "opponent" ]]
  then

    # get a team_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")

    #if not found
    if [[ -z $TEAM_ID ]]
    then

    # insert team
      INSERTING_TEAM_ID_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
    fi

   # get new team
   TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONONET'")
  fi

  if [[ $YEAR != "year" && $ROUND != "round" && $WINNER_GOALS != "winner_goals" && $OPPONENT_GOALS != "opponent_goals" ]]
  then
    #get winner_id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")

    #get opponent_id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")

    #get a game_id
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year='$YEAR' AND round = '$ROUND' AND winner_id='$WINNER_ID' AND opponent_id='$OPPONENT_ID' AND winner_goals = '$WINNER_GOALS' AND opponent_goals = '$OPPONENT_GOALS'")

    #if not found
    if [[ -z $GAME_ID ]]
    then
      # insert year, round, winner_id, opponoonet_id winner_goals, opponent_golas
      INSERTING_YEAR_ROUND_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YEAR', '$ROUND', '$WINNER_ID', '$OPPONENT_ID', '$WINNER_GOALS', '$OPPONENT_GOALS')") 

    fi
    
    # get new year, round, winner_goals, opponent_golas
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year='$YEAR' AND round = '$ROUND' AND winner_goals = '$WINNER_GOALS' AND opponent_goals = '$OPPONENT_GOALS'")
  fi
  
done