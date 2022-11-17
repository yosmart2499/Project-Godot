extends Resource

var max_score: int = 100;
var min_score: int = 0;

var high_score: int = 0;
var score: int = 0;

signal score_changed();

func add_score(value: int) -> void:
	self.score = min(self.score + value, self.max_score);
	self.emit_signal("score_changed");

func substract_score(value: int) -> void:
	self.score = max(self.score - value, self.min_score)
	self.emit_signal("score_changed");

func record_high_score() -> void:
	self.high_score = self.score;
	self.score = self.min_score;
