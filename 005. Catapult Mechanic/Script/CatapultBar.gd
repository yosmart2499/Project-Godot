extends Node2D

var bar_length;
var time_left;

func _ready():
	bar_length = 0;
	time_left = 0;

func set_bar_length(length, time):
	bar_length = length;
	time_left = time;

func place_in(pos):
	self.position = pos;

func _process(delta):
	update();

func _draw():
	draw_line(Vector2.ZERO, Vector2(0, -1) * bar_length/6, Color.greenyellow, 10);
	draw_line(Vector2(-30,-500), Vector2(-30, -500) + Vector2(0, 1) * time_left * 50, Color.red, 10);
