extends Area2D

signal hit;

export (int) var speed;

var screen_size;

func _ready():
	screen_size = get_viewport_rect().size;
	hide();

func _process(delta):
	var direction = Vector2.ZERO
	var velocity = Vector2.ZERO;
	
	if(Input.is_action_just_pressed("move_right")):
		direction.x += 1;
#		print("move_right");
	if(Input.is_action_just_pressed("move_left")):
		direction.x -= 1;

	if(direction.length() > 0):
		velocity += direction.normalized() * speed;

	position += velocity * delta;
	
	position.x = clamp(position.x, 0, screen_size.x);
	
func start(pos):
	position = pos;
	show();
	$CollisionShape2D.disabled = false;


func _on_Player_body_entered(body):
	hide();
	emit_signal("hit");
	$CollisionShape2D.set_deferred("disabled", true);
