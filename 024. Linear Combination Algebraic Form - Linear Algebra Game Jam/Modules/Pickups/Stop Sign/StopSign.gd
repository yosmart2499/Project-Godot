extends Area2D

var length: float = 64;
var rect: Rect2 = Rect2(Vector2.RIGHT, Vector2.DOWN);

func _physics_process(delta: float) -> void:
	self.update();
	$CollisionShape2D.shape.extents = Vector2(1,1) * (self.length);
	self.length -= 0.1;
	if(self.length < 0):
		self.queue_free();

func _draw() -> void:
	self.draw_rect(rect.grow(length), Color.aliceblue);

func _on_StopSign_body_entered(body) -> void:
	self.queue_free();
