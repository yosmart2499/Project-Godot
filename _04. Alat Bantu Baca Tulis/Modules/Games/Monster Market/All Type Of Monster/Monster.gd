extends Node2D

export (int, 10, 3000, 10) var berry_cost: int;

var max_speed: int = 500;
var min_speed: int = 100;
var speed: int = min_speed;
var bought: bool = false;
var move_direction: Vector2 = Vector2.RIGHT;
onready var save_path: String = "user://{0}.save".format([self.name]);

func _ready() -> void:
	speed = rand_range(min_speed, max_speed);
	self.bought = SaveLoading.load_from_path(self.bought, self.save_path);
	if(self.bought):
		self.bought_and_display();

func move_position(delta: float) -> void:
	self.position += self.move_direction * speed * delta;

func bought_and_display() -> void:
	self.rotate(PI);
	self.bought = true;
	SaveLoading.save_to_path(self.bought, self.save_path);


func _on_VisibilityNotifier2D_screen_exited() ->  void:
	self.move_direction *= -1;
