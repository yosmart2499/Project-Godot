extends Control

export var score_component: Resource = preload("res://Assets/Resources/score_component.tres");

func _ready() -> void:
	print(self.score_component.connect("score_changed", self, "change_score_label"));
	self.score_component.reset_everything();

func change_score_label() -> void:
	$Score.text = "Score: " + String(self.score_component.score);
	$HighScore.text = "High Score: " + String(self.score_component.high_score);
