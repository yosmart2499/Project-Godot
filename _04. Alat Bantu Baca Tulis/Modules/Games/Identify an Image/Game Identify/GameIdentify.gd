extends Control

func _on_GivenTimer_timeout() -> void:
	UserAccess.set_screen(UserAccess.Scene.WINNING_SCREEN);

func _on_SecondTimer_timeout() -> void:
	$VBoxContainer/TimerLabel.text = "Timer: " + String(int($GivenTimer.time_left));
