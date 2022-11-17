extends Control

func _ready():
	self.rect_position.x = get_viewport().size.x / 3;
	self.rect_position.y += 20;
	$StartArea.position = self.rect_size / 2;
	$StartArea/CollisionShape2D.shape.extents = self.rect_size / 2;
	$StartBackground.rect_size = self.rect_size;
