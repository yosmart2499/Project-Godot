extends Area2D

export var score_component: Resource = preload("res://Assets/Resources/score_component.tres");
export var shrink_speed: float = 40;

var radius: float = 64;

func _process(delta: float) -> void:
	self.radius -= self.shrink_speed * delta;
	# When I want to edit the shape of CollisionShape2D, I must make sure Local To Scene is true
	# Because in the docs say it was editor-only helper which is it makes to only respond with Godot editor
	# For custom shape either I create it my self or check true in Local To Scene.
	# That's my thought.
	$CollisionShape2D.shape.radius = int(self.radius);
	self.update();
	if(self.radius <= 0):
		self.queue_free();

func _draw() -> void:
	self.draw_circle(Vector2.ZERO, self.radius, Color.aqua);

func _on_Baloon_body_entered(_body: Node) -> void:
	self.score_component.add_score(3);
	self.queue_free();
