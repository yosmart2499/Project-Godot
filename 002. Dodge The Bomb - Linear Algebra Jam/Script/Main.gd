extends Node;

export (PackedScene) var plane_scene;

var score;
var screen_size;
var game_over = false;

func _ready():
	randomize();
	screen_size = get_viewport().size;

func _on_Player_hit_gameover():
	$ScoreTimer.stop();
	$PlaneTimer.stop();
	$HUD.show_game_over();

func _on_HUD_start_game():
	score = 0;
	$Player.start($StartPosition.position);
	$StartTimer.start();
	$HUD.update_score(score);
	$HUD.show_messsage("Get Ready!");
	get_tree().call_group("planeNbomb", "queue_free");

func _on_PlaneTimer_timeout():
	var plane = plane_scene.instance();
	var plane_spawn_location = Vector2(0,rand_range(0, screen_size.y/4));
	plane.position = plane_spawn_location;
	
	add_child(plane);

func _on_ScoreTimer_timeout():
	score += 1;
	$HUD.update_score(score);

func _on_StartTimer_timeout():
	$PlaneTimer.start();
	$ScoreTimer.start();
