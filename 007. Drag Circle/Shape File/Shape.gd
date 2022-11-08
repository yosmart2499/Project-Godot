extends Area2D

signal start_touched;
signal end_touched;

var touched_other_area: bool;
var scaling_area: Vector2;
var rotate_area: float;
var circle: bool = false;
var rectangle: bool = false;
var entered_area: Array = [];
var on_area: bool = false;


func _ready():
	scaling_area = Vector2.ZERO;
	rotate_area = 0.0;
	touched_other_area = false;


func _process(_delta):
	if(touched_other_area && scaling_area.angle() >= 0):
		return;
	self.scale +=  scaling_area ;
	self.scale.x = clamp(self.scale.x, 1,5);
	self.scale.y = clamp(self.scale.y, 1,5);
	if(rectangle):
		self.rotation += rotate_area;
	scaling_area = Vector2.ZERO;
	rotate_area = 0.0;


func _input(event):
	if(event is InputEventScreenDrag):
		if($TouchScreenClass.get_drag_direction(event.relative, 0) == Vector2(-1,1)):
			scaling_area = Vector2(0.1,0.1) * -1;
			if(circle):
				return;
			if($CollisionShape2D.shape.extents.x == $CollisionShape2D.shape.extents.y):
				return;
			if($CollisionShape2D.shape.extents.x > $CollisionShape2D.shape.extents.y):
				scaling_area = Vector2(0.1,0.0) * -1;
			else:
				scaling_area = Vector2(0.0,0.1) * -1;
		if($TouchScreenClass.get_drag_direction(event.relative, 0) == Vector2(1,-1)):
			scaling_area = Vector2(0.1,0.1);
			if(circle):
				return;
			if($CollisionShape2D.shape.extents.x == $CollisionShape2D.shape.extents.y):
				return;
			if($CollisionShape2D.shape.extents.x > $CollisionShape2D.shape.extents.y):
				scaling_area = Vector2(0.1,0.0);
			else:
				scaling_area = Vector2(0.0,0.1);
	
	if(event is InputEventMouseButton):
		if(event.is_pressed() && on_area):
			if(event.button_index == BUTTON_WHEEL_UP):
				rotate_area = 0.1;
			if(event.button_index == BUTTON_WHEEL_DOWN):
				rotate_area = -0.1;
	
func create_circle_shape():
	$TouchScreenClass.shape = CircleShape2D.new();
	$TouchScreenClass.shape.radius = 32;
	$CollisionShape2D.shape = CircleShape2D.new();
	$CollisionShape2D.shape.radius = 32;
	$SpriteContainer/CircleSprite.visible = true;
	circle = true;

# Remember to add condition where rectangle is not squared grow direction will be either up or right
func create_rectangle_shape(grow_direction):
# The touchscreen will aticavate if the intersection of the two shape whatc out. Maybe create better touchscreen clas.
	$TouchScreenClass.shape = RectangleShape2D.new();
	$TouchScreenClass.shape.extents = Vector2(32*grow_direction.x,32*grow_direction.y);
	$CollisionShape2D.shape = RectangleShape2D.new();
	$CollisionShape2D.shape.extents = Vector2(32*grow_direction.x,32*grow_direction.y);
	var area_size = $CollisionShape2D.shape.extents;
	if(area_size.x != area_size.y):
		rectangle = true;
	var texture_size = $SpriteContainer/RectangleSprite.texture.get_size();
	var sx = area_size.x * 2 / texture_size.x;
	var sy = area_size.y * 2 / texture_size.y;
	$SpriteContainer/RectangleSprite.scale = Vector2(sx,sy);
	$SpriteContainer/RectangleSprite.visible = true;


func iterate_through_area():
	for area in entered_area:
		if("Start" in area.name):
			emit_signal("start_touched");
		if("End" in area.name):
			emit_signal("end_touched");
		


func _on_Shape_area_entered(area):
	entered_area.append(area);
	iterate_through_area();
	if(not "Start" in area.name && not "End" in area.name):
		area.iterate_through_area();
	touched_other_area = true;
	if(area.name == "NoSpawnArea"):
		return;
	self.modulate = Color(0.564706, 1, 0.501961, 1);

func _on_Shape_area_exited(area):
	if(entered_area.size() == 1):
		self.modulate = Color.white;
		self.modulate = Color.white;
		touched_other_area = false;
	entered_area.erase(area);
	iterate_through_area();
	if(not "Start" in area.name && not "End" in area.name):
		area.iterate_through_area();

func _on_Shape_mouse_entered():
	on_area = true;


func _on_Shape_mouse_exited():
	on_area = false;
