extends Node

export var score_component: Resource = preload("res://Assets/Resources/score_component.tres");

func _on_GameOverTimer_timeout():
	score_component.record_high_score();
	get_parent().game_over();

func _on_SecondTimer_timeout():
	if($GameOverTimer.time_left < 10):
		$TimerLabel.text = "0" + String($GameOverTimer.time_left);
	else:
		$TimerLabel.text = String($GameOverTimer.time_left);
