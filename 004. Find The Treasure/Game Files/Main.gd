extends Node

var score;
var game_time;

func _ready():
	pass

func _on_HUD_start_game():
	score = 0;
	game_time = 30;
	$HUD/TimeLabel.text = str(game_time);
	$HUD.update_score(score);
	$HUD.show_message("Get Ready");
	$StartTimer.start();
	yield($StartTimer, "timeout");
	$GameTimer.start();

func _on_StartTimer_timeout():
	$Map.start_the_map($ProducePosition.position);

func _on_Map_out_of_bounds():
	$HUD.show_game_over();
	$GameTimer.stop();

func _on_Map_picked_treasure():
	score += 1;
	$HUD.update_score(score);

func _on_Map_bomb_touched():
	score = max(0, score - 1);
	$HUD.update_score(score);

func _on_GameTimer_timeout():
	game_time -= 1;
	$HUD/TimeLabel.text = str(game_time);
	if(game_time == 0):
		$GameTimer.stop();
		$Map.stop_the_map();
		$HUD.show_game_over();
