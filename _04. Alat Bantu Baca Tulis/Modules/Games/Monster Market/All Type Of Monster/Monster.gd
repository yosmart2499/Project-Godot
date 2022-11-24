extends Node2D

export (int, 10, 3000, 10) var berry_cost: int;

var bought: bool = false;
onready var save_path: String = "user://{0}.save".format([self.name]);

func _ready() -> void:
	self.bought = SaveLoading.load_from_path(self.bought, self.save_path);
	if(self.bought):
		self.bought_and_display();

func bought_and_display() -> void:
	self.rotate(PI);
	self.bought = true;
	SaveLoading.save_to_path(self.bought, self.save_path);
