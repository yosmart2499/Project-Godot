extends CanvasLayer

signal start_game;

func _ready():
	pass

func update_score(score):
	$ScoreLabel.text = "Score: " + str(score);

func show_message(text):
	$MessageLabel.text = text;
	$MessageLabel.show();
	$MessageTimer.start();

func show_game_over():
	show_message("Better Luck Next Time!");
	yield($MessageTimer, "timeout");
	
	$MessageLabel.text = "Dodge The\n Bullet!";
	$MessageLabel.show();
	
	yield(get_tree().create_timer(1), "timeout");
	$StartButton.show();

func _on_MessageTimer_timeout():
	$MessageLabel.hide();
	
func _on_StartButton_pressed():
	$StartButton.hide();
	emit_signal("start_game");
