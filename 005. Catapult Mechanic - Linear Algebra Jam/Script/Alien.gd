extends Area2D

signal alien_hit;

var screen_size;

func _ready():
	hide();
	screen_size = get_viewport().size;

func _on_Alien_body_entered(body):
	self.emit_signal("alien_hit");
	body.queue_free();

func summon_alien(side):
	show();
	if(side):
		self.position = Vector2(rand_range(0, screen_size.x/2), rand_range(0, screen_size.y/4));
	else:
		self.position = Vector2(rand_range(screen_size.x/2, screen_size.x), rand_range(0, screen_size.y/4));
