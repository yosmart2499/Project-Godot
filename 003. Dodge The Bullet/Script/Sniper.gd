extends Node2D

export (PackedScene) var bullet_scene;

signal done_firing;
signal bullet_fired;

var gun_fired;

func _ready():
	self.position = get_viewport().size/2;
	gun_fired = false;
	hide();
#	rotateNfire_sniper(rotate_direction);
#	var firing_area = [PI/3, PI/1.5];
#	var firing_area = [PI/3, PI/1.5, -0.75*PI, -PI/3, 2*PI, PI/2, PI, -PI/2,PI/3, PI/1.5, -0.75*PI, -PI/3, 2*PI, PI/2, PI, -PI/2];
#	start_firing(firing_area);

#func _process(delta):
#	if( Input.is_action_pressed("push_right") ):
#		rotate_direction += 0.1;
#	if( Input.is_action_pressed("push_left") ):
#		rotate_direction -= 0.1;
#	# Below code is nice way to limit the value in certain range using mod. I forget about that.
#	rotate_direction = fmod(rotate_direction, 2*PI)
#
#	self.rotation = rotate_direction;

func rotateNfire_sniper(direction):
	var bullet = bullet_scene.instance();
	
	$Sprite.rotation = direction - PI/2;
	bullet.rotateNfire_bullet(direction);
	
	add_child(bullet)

func start_firing(fire_area):
	var cooldown = 1/float(fire_area.size());
	for direction in fire_area:
		if(gun_fired == false):
			return;
		yield(get_tree().create_timer(cooldown), "timeout");
		rotateNfire_sniper(direction);
		emit_signal("bullet_fired");
	emit_signal("done_firing");
