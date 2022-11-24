extends Area2D

var length: float = 64;
var rect: Rect2 = Rect2(Vector2.RIGHT, Vector2.DOWN);

func _physics_process(delta: float) -> void:
	self.update();
	print(self.length);
	$CollisionShape2D.shape.extents = Vector2(1,1) * (self.length / 2);
	self.length -= 1;

func _draw() -> void:
	self.draw_rect(rect.grow(length), Color.aliceblue);
