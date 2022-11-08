extends Area2D;
signal hit;

export var speed = 0; # Pixel/sec
var screen_size;

func _ready():
	screen_size = get_viewport_rect().size;
	hide();

func _process(delta):
	var velocity = Vector2.ZERO;
	if ( Input.is_action_pressed("move_right") ):
		velocity.x += 1;
	if ( Input.is_action_pressed("move_left") ):
		velocity.x -= 1;
	if ( Input.is_action_pressed("move_down") ):
		velocity.y += 1;
	if ( Input.is_action_pressed("move_up") ):
		velocity.y -= 1;
	
	if ( velocity.length() > 0 ):
		velocity = velocity.normalized() * speed;
		$AnimatedSprite.play();
	else:
		$AnimatedSprite.stop();
	
	position += velocity * delta;
	position.x = clamp(position.x, 0, screen_size.x);
	position.y = clamp(position.y, 0, screen_size.y);
	
	if ( velocity.x != 0 ):
		$AnimatedSprite.animation = ("walk" if( velocity.y >= 0 ) else "up");
		$AnimatedSprite.flip_v = false; # velocity.y doesn't need this because it's already happening in line 39.
		$AnimatedSprite.flip_h = velocity.x < 0;
	elif ( velocity.y != 0 ):
		$AnimatedSprite.animation = "up";
		$AnimatedSprite.flip_v = velocity.y > 0; # Remember minus value is up and positive value is down

func _on_Player_body_entered(body):
	hide();
	emit_signal("hit");
	$CollisionShape2D.set_deferred("disabled", true);
#	Using code below will give the errors result.
#	$CollisionShape2D.disabled = true;
#	Return this error E 0:00:12.378   area_set_shape_disabled: Can't change this state while flushing queries. Use call_deferred() or set_deferred() to change monitoring state instead.

	
func say_hello():
	print("Hello World!");

func start(pos):
	position = pos;
	show()
	$CollisionShape2D.disabled = false;
