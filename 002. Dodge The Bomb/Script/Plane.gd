extends Node2D

export (PackedScene) var bomb_scene;

var two_way_trip = false;
var velocity = Vector2(rand_range(150.0, 250.0), 0.0);

func _ready():
	self.linear_velocity = velocity;

func _on_DropTimer_timeout():
	var bomb = bomb_scene.instance();
	bomb.position = $DropPoint.position;
	add_child(bomb);

func _on_VisibilityNotifier2D_screen_exited():
	if(two_way_trip == false):
		self.linear_velocity = -velocity;
		$Sprite.flip_h = false;
		two_way_trip = true;
	else:
		$ExitTimer.autostart = true;

func _on_ExitTimer_timeout():
	queue_free();
