extends Node2D

export (int) var push_scale;
export (float) var bounce_resistance;
export (float) var resistance_overtime;
export (int) var speed_cap;

var velocity_player;
var screen_size;
signal hit;

func _ready():
	velocity_player = Vector2.ZERO;
	screen_size = get_viewport().size;
	hide();

func _process(delta):
	var velocity_push = Vector2.ZERO;
	
	if( Input.is_action_pressed("push_up") ):
		velocity_push.y -= 1;
	if( Input.is_action_pressed("push_down") ):
		velocity_push.y += 1;
	if( Input.is_action_pressed("push_right") ):
		velocity_push.x += 1;
	if( Input.is_action_pressed("push_left") ):
		velocity_push.x -= 1;
	
#	velocity_push *= push_scale;
	
	if( velocity_push.length() > 0 ):
		velocity_push = velocity_push.normalized() *  push_scale;
	
	if( Input.is_action_pressed("push_nitro") ):
		velocity_push *= 3;
	
	velocity_player += velocity_push;
	self.position += velocity_player * delta;
	
	self.position.x = clamp(self.position.x, 0, screen_size.x);
	self.position.y = clamp(self.position.y, 0, screen_size.y);

	if( self.position.x == screen_size.x || self.position.x == 0 ):
		velocity_player.x = -velocity_player.x;
		velocity_player.x /= bounce_resistance ;
	if( self.position.y == screen_size.y || self.position.y == 0 ):
		velocity_player.y = -velocity_player.y;
		velocity_player.y /= bounce_resistance;
	
	velocity_player.x /= resistance_overtime;
	velocity_player.y /= resistance_overtime;
	
	velocity_player.x = clamp(velocity_player.x, -speed_cap, speed_cap);
	velocity_player.y = clamp(velocity_player.y, -speed_cap, speed_cap);


func _on_Player_body_entered(body):
	hide();
	emit_signal("hit");
	$CollisionShape2D.set_deferred("disabled", true);

func start(pos):
	self.position = pos;
	show();
	$CollisionShape2D.disabled = false;
