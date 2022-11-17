extends RigidBody2D

export var impulses: Resource = preload("res://Assets/Resources/impulses_component.tres");
export var launch_delay: int = 25000;
export var fast_rotation: float = 0.15;

var unit_direction: Vector2 = Vector2.RIGHT;

onready var screen_size: Vector2 = get_viewport().get_visible_rect().size;

func get_input() -> void:
	if(Input.is_action_pressed("ui_left")):
		self.rotate_player_component(-fast_rotation);
	if(Input.is_action_pressed("ui_right")):
		self.rotate_player_component(fast_rotation);
	if(self.linear_velocity.length_squared() < launch_delay):
		$Sprite.modulate = Color.white;
		if(Input.is_action_pressed("ui_accept")):
			self.impulses.add_impulses();
		if(Input.is_action_just_released("ui_accept")):
			self.apply_central_impulse(self.unit_direction * self.impulses.value);
			self.impulses.reset_impulses();
	else:
		$Sprite.modulate = Color.gray;
		print(self.linear_velocity.length_squared());

func rotate_player_component(radians: float):
		self.unit_direction = self.unit_direction.rotated(radians);
		$Sprite.rotate(radians);
		$CollisionShape2D.rotate(radians);

func _physics_process(_delta: float) -> void:
	self.get_input();
	self.update();

func _draw() -> void:
	var points: PoolVector2Array = [Vector2($Sprite.position.x, $Sprite.position.y - 70).rotated($Sprite.rotation),
	Vector2($Sprite.position.x - 20, $Sprite.position.y - 50).rotated($Sprite.rotation),
	Vector2($Sprite.position.x + 20, $Sprite.position.y - 50).rotated($Sprite.rotation)];
	self.draw_colored_polygon(points, Color.aliceblue);


func _integrate_forces(_state: Physics2DDirectBodyState) -> void:
	if(self.position.x > self.screen_size.x):
		self.linear_velocity.x *= -1;
	elif(self.position.x < 0):
		self.linear_velocity.x *= -1;
	elif(self.position.y > self.screen_size.y):
		self.linear_velocity.y *= -1;
	elif(self.position.y < 0):
		self.linear_velocity.y *= -1;

func _on_VisibilityNotifier2D_screen_exited():
	print("BuGsS!!!");
	self.queue_free();
