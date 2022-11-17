extends Control

signal start_game();
signal quit_game();

export var score_component: Resource = preload("res://Assets/Resources/score_component.tres");

func _ready() -> void:
	print(self.score_component.connect("score_changed", self, "change_score_label"));
	self.score_component.reset_everything();

func change_score_label() -> void:
	$HighScore.text = "Score: " + String(self.score_component.high_score);

func _on_PlayBtn_pressed():
	self.emit_signal("start_game");

func _on_QuitBtn_pressed():
	self.emit_signal("quit_game");
