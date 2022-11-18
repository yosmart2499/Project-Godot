extends Node

onready var screen_size: Vector2 = get_viewport().get_visible_rect().size;

func _ready():
	$Player.position =  self.screen_size / 2;

func _unhandled_key_input(event: InputEventKey) -> void:
	if(event.is_action_pressed("ui_left")):
		$HBoxContainer/HBoxContainer/VBoxContainer/LeftHelperBtn.pressed = true;
		$HBoxContainer/HBoxContainer/VBoxContainer/LeftHelperBtn2.pressed = true;
	if(event.is_action_released("ui_left")):
		$HBoxContainer/HBoxContainer/VBoxContainer/LeftHelperBtn.pressed = false;
		$HBoxContainer/HBoxContainer/VBoxContainer/LeftHelperBtn2.pressed = false;
	if(event.is_action_pressed("ui_right")):
		$HBoxContainer/HBoxContainer/VBoxContainer2/RightHelperBtn.pressed = true;
		$HBoxContainer/HBoxContainer/VBoxContainer2/RightHelperBtn2.pressed = true;
	if(event.is_action_released("ui_right")):
		$HBoxContainer/HBoxContainer/VBoxContainer2/RightHelperBtn.pressed = false;
		$HBoxContainer/HBoxContainer/VBoxContainer2/RightHelperBtn2.pressed = false;
	if(event.is_action_pressed("ui_accept")):
		$HBoxContainer/SpaceHelperBtn.pressed = true;
	if(event.is_action_released("ui_accept")):
		$HBoxContainer/SpaceHelperBtn.pressed = false;

func _on_GameOverTimer_timeout() -> void:
	self.queue_free();

func _on_SecondTimer_timeout() -> void:
	if($GameOverTimer.time_left < 10):
		$TimerLabel.text = "0" + String(int($GameOverTimer.time_left));
	else:
		$TimerLabel.text = String(int($GameOverTimer.time_left));
