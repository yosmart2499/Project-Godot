extends RigidBody2D

func spawn_location(pos):
	self.position = pos;
	update();
	
func _draw():
	var line_thick = 6;
	var corner = 20;
	draw_line(Vector2(-corner,-corner), Vector2(corner,-corner), Color.white, line_thick);
	draw_line(Vector2(corner,-corner), Vector2(corner,corner), Color.white, line_thick);
	draw_line(Vector2(corner,corner), Vector2(-corner,corner), Color.white, line_thick);
	draw_line(Vector2(-corner,corner), Vector2(-corner,-corner), Color.white, line_thick);
