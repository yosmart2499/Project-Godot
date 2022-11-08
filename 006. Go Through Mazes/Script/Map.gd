extends Node2D

export (PackedScene) var obstacle_scene;

signal start_game;
signal end_game;

var origin_with_margin;
var vector_gap_between;
var screen_size;
var iteration_horizontal;
var iteration_vertical;

func _ready():
	screen_size = get_viewport().size;
	vector_gap_between = 64;
	iteration_horizontal = int(screen_size.x/vector_gap_between);
	iteration_vertical = int(screen_size.y/vector_gap_between);
	origin_with_margin = Vector2(32,32);
	
	$StartArea.position = Vector2(vector_gap_between * iteration_horizontal, vector_gap_between * iteration_vertical) - origin_with_margin * 2;
	$EndArea.position += origin_with_margin * 2;
	toggle_hideNshow_area();

func toggle_hideNshow_area():
	$StartArea.visible = !$StartArea.visible;
	$EndArea.visible = !$EndArea.visible;

func iterate_through_screen(total_obstacle):
	var all_vector_obstacle = []
	for _number_obstacle in range(total_obstacle):
		var obstacle_position = random_pos();
		while(all_vector_obstacle.has(obstacle_position)):
			obstacle_position = random_pos();
		summon_obstacle(obstacle_position);
		all_vector_obstacle.append(obstacle_position);

func random_pos():
	var iteration = random_iteration(iteration_horizontal, iteration_vertical);
	var edge = edges_iteration(iteration_horizontal,iteration_vertical);
	
	while(edge.has(iteration)):
		iteration = random_iteration(iteration_horizontal, iteration_vertical);

	return Vector2(vector_gap_between * iteration.x, vector_gap_between * iteration.y);

func edges_iteration(horizontal, vertical):
	return [Vector2(0,0),Vector2(0,1),Vector2(1,0),Vector2(1,1), Vector2(horizontal-1,vertical-1), Vector2(horizontal-2,vertical-1), Vector2(horizontal-1,vertical-2), Vector2(horizontal-2,vertical-2)]

func random_iteration(horizontal, vertical):
	return Vector2(randi()%horizontal, randi()%vertical);

func summon_obstacle(location):
	var obstacle = obstacle_scene.instance();
	obstacle.spawn_location(origin_with_margin + location);
	add_child(obstacle);

func free_obstacle():
	get_tree().call_group("obstacles", "queue_free");

func _on_StartArea_area_exited(_area):
	emit_signal("start_game");

func _on_EndArea_area_entered(_area):
	emit_signal("end_game");
