extends Control

func _ready():
	self.rect_position.x = get_viewport().size.x / 3;
	self.rect_position.y = get_viewport().size.y - self.rect_size.y - 20;
	$EndArea.position = self.rect_size / 2;
	$EndArea/CollisionShape2D.shape.extents = self.rect_size / 2;
	$EndBackground.rect_size = self.rect_size;
