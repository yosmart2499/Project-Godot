extends Node2D

var angle;
var angle_limit;
var stop;

func _ready():
	angle = 0;
	angle_limit = [-PI/2.1, PI/2.1];
	self.hide();
	stop = false;

func _draw():
	draw_line(Vector2.ZERO, Vector2(0, -1).normalized() * 100, Color.white, 1);

func spawn_in(pos):
	show();
	self.position = pos;

func _process(delta):
	if(stop):
		return;
	player_input();
	update();
	
	self.rotation = angle;

func set_angle_limitation(limit):
	angle_limit = limit;
	angle = 0;

func player_input():
	if(Input.is_action_pressed("catapult_angle_right")):
		angle = angle + 0.023;
		angle = clamp(angle, angle_limit[0], angle_limit[1]);
		if(angle_limit[0] == 0 && angle < PI/4 || angle_limit[1] == 0 && angle > -PI/4):
			angle += 0.025;
	if(Input.is_action_pressed("catapult_angle_left")):
		angle = angle - 0.023;
		angle = clamp(angle, angle_limit[0], angle_limit[1]);
		if(angle_limit[0] == 0 && angle < PI/4 || angle_limit[1] == 0 && angle > -PI/4):
			angle -= 0.025;

