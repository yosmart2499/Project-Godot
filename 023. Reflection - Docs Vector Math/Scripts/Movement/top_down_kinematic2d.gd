extends KinematicBody2D

export (int, 0, 1000) var move_speed: int = 100;

var velocity: Vector2 = Vector2();
var direction: Vector2 = Vector2();

func get_input() -> void:
	self.direction = Vector2.ZERO;
	if(Input.is_action_pressed("ui_up")):
		self.direction += Vector2.UP;
	if(Input.is_action_pressed("ui_down")):
		self.direction += Vector2.DOWN;
	if(Input.is_action_pressed("ui_left")):
		self.direction += Vector2.LEFT;
	if(Input.is_action_pressed("ui_right")):
		self.direction += Vector2.RIGHT;
	if(self.direction.length() != 0):
		self.direction = self.direction.normalized();

func _physics_process(delta: float) -> void:
	self.get_input();
	self.velocity += self.direction * self.move_speed;
	var collision = move_and_collide(self.velocity * delta);
	if(collision):
		collision.collider.called_from_KinematicCollision2D();
		print(collision.remainder);
		print(self.velocity);
		var reflect: Vector2 = collision.remainder.bounce(collision.normal);
		self.velocity = self.velocity.bounce(collision.normal);
		self.move_and_collide(reflect);

func _on_VisibilityNotifier2D_screen_exited():
	self.get_tree().reload_current_scene();
