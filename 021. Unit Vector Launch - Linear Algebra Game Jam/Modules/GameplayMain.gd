extends Node

export var score_component: Resource = preload("res://Assets/Resources/score_component.tres");

onready var screen_size: Vector2 = get_viewport().get_visible_rect().size;

func _ready():
	$Player.position = screen_size / 2;

func _on_GameOverTimer_timeout():
	score_component.record_high_score();
	get_parent().game_over();

func _on_SecondTimer_timeout():
	if($GameOverTimer.time_left < 10):
		$TimerLabel.text = "0" + String(int($GameOverTimer.time_left));
	else:
		$TimerLabel.text = String(int($GameOverTimer.time_left));
