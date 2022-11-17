extends Node

export (PackedScene) var boulder_scene;
export (PackedScene) var bar_scene;

var pull_power;
var switch;
var score;
var game_over;

func _ready():
	$PlayerPosition.position.x = get_viewport().size.x / 2;
	$PlayerPosition.position.y = get_viewport().size.y - 100;
	pull_power = 500;
	score = 0;
	game_over = false;

func _process(delta):
	randomize();
	if(game_over):
		return;
	if(Input.is_action_pressed("catapult_release")):
		pull_power = clamp(pull_power + 50, 500, 3000);
	if(Input.is_action_just_released("catapult_release")):
		var boulder = boulder_scene.instance();
		boulder.launch_in($PlayerPosition.position);
		boulder.boulder_velocity($Player.angle, pull_power);
		add_child(boulder);
		pull_power = 500;
	$Bar.set_bar_length(pull_power, $AreaChangeTimer.time_left);
	$HUD.update_game_timer(int($GameTimer.time_left));

func _on_AreaChangeTimer_timeout():
	start_switch_area();
	get_tree().call_group("boulders", "queue_free");

func start_switch_area():
	switch = !switch;
	$ShootingArea.switch_area(switch);
	$Alien.summon_alien(switch);
	if(switch):
		$Player.set_angle_limitation([0, PI/2.1]);
	else:
		$Player.set_angle_limitation([-PI/2.1, 0]);

func _on_HUD_new_game():
	score = 0;
	$Player.stop = false;
	$Player.spawn_in($PlayerPosition.position);
	$Bar.place_in($BarPosition.position);
	
	$HUD.update_score(score);
	$HUD.show_message("Get Ready!");
	
	switch = true;
	pull_power = 500;
	game_over = false;
	
	$StartTimer.start();

func _on_Alien_alien_hit():
	score += 1;
	$HUD.update_score(score);

func _on_StartTimer_timeout():
	$AreaChangeTimer.start();
	start_switch_area();
	$GameTimer.start();
	$Player.show();
	$Alien.show();
	$Bar.show();
	$ShootingArea.show();
	$Alien/CollisionShape2D.set_deferred("disabled", false);

func _on_GameTimer_timeout():
	game_over = true;
	$Player.set_angle_limitation([-PI/2.1, PI/2.1]);
	$AreaChangeTimer.stop();
	get_tree().call_group("boulders", "queue_free");
	$Player.stop = true;
	$HUD.show_game_over();
	$Player.hide();
	$Alien.hide();
	$Alien/CollisionShape2D.set_deferred("disabled", true);
	$Bar.hide();
	$ShootingArea.hide();
