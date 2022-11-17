extends CanvasLayer

signal start_game;

func _ready():
	new_game_label();

func update_messages(text):
	$MessageLabel.text = text;
	$MessageLabel.show();

func get_ready():
	update_messages("Get Ready!");
	$MessageTimer.start();

func new_game_label():
	update_messages("Go Through The Maze!");
	$StartButton.show();

func game_over_label():
	update_messages("You Touched The Obstacle.");
	yield(get_tree().create_timer(2), "timeout");
	new_game_label();

func _on_StartButton_pressed():
	$StartButton.hide();
	$MessageTimer.start();
	yield(get_tree().create_timer(2), "timeout");	
	emit_signal("start_game");

func _on_MessageTimer_timeout():
	$MessageLabel.hide();
