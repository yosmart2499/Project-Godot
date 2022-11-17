extends Node

func _ready():
	$Player.connect("pressed_input", $TextUI, "update_input");
	
	get_tree().call_group("timers", "activate_timer");

func every_timer_gone(timer_name):
	print(timer_name);
