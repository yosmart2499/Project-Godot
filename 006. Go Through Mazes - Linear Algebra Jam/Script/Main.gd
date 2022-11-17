extends Node

export (int) var scalar;

var is_game_over = false;

func _ready():
	is_game_over = false;

func _on_Controller_confirm():
	if(is_game_over):
		return;
	$VectorsStorage.adjust_vector_set(scalar);
	$Controller.moving_process();
	
	for vector in $VectorsStorage.sets_vectors_direction:
		if(is_game_over):
			break;
		move_player(vector);
		yield(get_tree().create_timer(1), "timeout");
	
	move_player(Vector2.ZERO);
	$Controller.moving_process();
	$VectorsStorage.reset_vector_set();
	
func move_player(vector):
	$Player.update_move(vector);

func _on_PrintoutTimer_timeout():
	pass;
#	print($VectorsStorage.sets_vectors_direction);

func _on_UI_start_game():
	is_game_over = false;
	randomize();
	$Map.iterate_through_screen(40);
	$Map.toggle_hideNshow_area();
	$Player.toggle_visible_player();

func game_over():
	$UI.game_over_label();
	$Map.free_obstacle();
	$Map.toggle_hideNshow_area();

func _on_Player_game_over():
	is_game_over = true;
	game_over();

func _on_Map_end_game():
	is_game_over = true;
	$Map.free_obstacle();
	$UI.update_messages("You Found The Way Out!");
	yield(get_tree().create_timer(2), "timeout");
	$UI.update_messages("Wanna Do Another Run?");
	$Player.toggle_visible_player();
	$Map.toggle_hideNshow_area();
	yield(get_tree().create_timer(2), "timeout");
	$Player.start_pos();
	$UI.new_game_label();
