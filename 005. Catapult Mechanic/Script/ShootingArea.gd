extends CanvasLayer

var screen_size;

func _ready():
	hide();
	screen_size = get_viewport().size;
	$LeftArea.rect_size = Vector2(screen_size.x/2, screen_size.y);
	$RightArea.margin_left = screen_size.x/2;
	$RightArea.rect_size = Vector2(screen_size.x/2, screen_size.y);
	$LeftArea.color = Color(0,0,0,0.5);
	$RightArea.color = Color(0,0,0,0.5);

func show_area(showORhide):
	if(showORhide):
		self.show();
	else:
		self.hide();



func switch_area(leftORright):
	self.show();
	if(leftORright):
		$LeftArea.color = Color(0,0,0,0.5);
		$RightArea.color = Color.transparent;
	else:
		$LeftArea.color = Color.transparent;
		$RightArea.color = Color(0,0,0,0.5);
