extends Control

func _ready():
	$NoSpawnArea.position = self.rect_size / 2;
	$NoSpawnArea/CollisionShape2D.shape.extents = self.rect_size / 2;
	$UIBackground.rect_size = self.rect_size;
