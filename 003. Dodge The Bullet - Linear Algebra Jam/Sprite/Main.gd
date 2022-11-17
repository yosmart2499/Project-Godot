extends Node

var score;
var firing_area;

func _ready():
	randomize();

func start_game():
	score = 0;
	$Player.start($StartPosition.position);
	
	$StartTimer.start();
	$HUD.update_score(score);
	$HUD.show_message("Get Ready!");
	firing_area = [];
	$GetReadyTimer.start();
	$Sniper.gun_fired = true;

func game_over():
	$Sniper.gun_fired = false;
	$Sniper.hide();
	$HUD.show_game_over();

func _on_StartTimer_timeout():
	$GetReadyTimer.start();
	$Sniper.show();

func _on_GetReadyTimer_timeout():
	var random_direction = rand_range(0, 2*PI);
	firing_area.append(random_direction);
	firing_area.shuffle();
	$Sniper.start_firing(firing_area);
	print("yes");

func _on_Sniper_bullet_fired():
	score += 1;
	$HUD.update_score(score);

func _on_Sniper_done_firing():
	$GetReadyTimer.start();

