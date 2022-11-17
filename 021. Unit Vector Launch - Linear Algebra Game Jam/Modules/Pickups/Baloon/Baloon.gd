extends Area2D

export var shrink_speed: float = 40;

var radius: float = 64;

func _ready():
	$CollisionShape2D.shape.radius = radius;

func _process(delta: float):
	self.radius -= shrink_speed * delta;
	$CollisionShape2D.shape.radius = radius;
	self.update();
	if(self.radius <= 0):
		print("Bye bye");
		self.queue_free();

func _draw() -> void:
	self.draw_circle(Vector2.ZERO, self.radius, Color.aqua);
