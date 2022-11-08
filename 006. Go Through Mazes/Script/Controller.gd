extends Node

signal up;
signal down;
signal right;
signal left;
signal confirm;

var still_moving;

func _ready():
	still_moving = false;

func _process(_delta):
	if(still_moving):
		return;
	if(Input.is_action_just_pressed("up")):
		emit_signal("up");
	if(Input.is_action_just_pressed("down")):
		emit_signal("down");
	if(Input.is_action_just_pressed("left")):
		emit_signal("left");
	if(Input.is_action_just_pressed("right")):
		emit_signal("right");
	if(Input.is_action_just_pressed("confirm")):
		emit_signal("confirm");

func moving_process():
	still_moving = !still_moving;
