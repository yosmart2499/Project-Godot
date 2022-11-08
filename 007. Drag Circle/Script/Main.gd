extends Node

var screen_size;
var margin = 100;
var won_game_once = false;

func _ready():
	screen_size = get_viewport().size;
	$PlayerController.give_spaces([3,3,3]);


func _on_PlayerController_won_game():
	if(not won_game_once):
		$WinScreen.start_reloading();
