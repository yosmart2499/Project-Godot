extends CanvasLayer

signal new_game;

func update_score(score):
	$ScoreLabel.text = str(score);

func update_game_timer(timer):
	$GameTimerLabel.text = str(timer);

func show_message(text):
	$MessageLabel.text = text;
	$MessageLabel.show();
	$MessageTimer.start();

func show_game_over():
	show_message("Game Over!");
	
	yield($MessageTimer, "timeout");
	$MessageLabel.text = "Hit The Alien!";
	$MessageLabel.show();
	
	yield(get_tree().create_timer(1), "timeout");
	$StartButton.show();

func _on_StartButton_pressed():
	emit_signal("new_game");
	$StartButton.hide();

func _on_MessageTimer_timeout():
	$MessageLabel.hide();
