extends CanvasLayer

signal start_game;

func _ready():
	pass

func show_message(text):
	$MessageLabel.text = text;
	$MessageLabel.show();
	$MessageTimer.start();

func show_game_over():
	show_message("Welp It Was a Good Run!");
	yield($MessageTimer, "timeout");
	
	$MessageLabel.text = "Want Another Run?";
	$MessageLabel.show();
	yield(get_tree().create_timer(2), "timeout");
	
	$MessageLabel.text = "Find The Treasure!";
	$StartButton.show();

func update_score(score):
	$ScoreLabel.text = str(score);

func _on_StartButton_pressed():
	$StartButton.hide();
	emit_signal("start_game");

func _on_MessageTimer_timeout():
	$MessageLabel.hide();
