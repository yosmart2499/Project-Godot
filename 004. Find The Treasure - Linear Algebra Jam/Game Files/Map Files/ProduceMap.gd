extends Node2D;

signal produce_grid;
signal produce_screen_exited;

func _ready():
	hide();

func start_produce(pos):
	show();
	self.position = pos;
	produce_grid();
	$WalkTimer.start();

func stop_produce():
	hide();
	$WalkTimer.stop();

func produce_grid():
	emit_signal("produce_grid");

func _on_Raycast_touch():
	self.rotate(-PI/2);
	if(self.rotation  < 0):
		self.rotation = 2*PI - PI/2;
	self.rotation = fmod(self.rotation, 2*PI);

func _on_WalkTimer_timeout():
	walking()
	
	self.rotate(PI/2);
	self.rotation = fmod(self.rotation, 2*PI);

	produce_grid();

func walking():
	var walking_direction = int(self.rotation);
	
	if(walking_direction == 0):
		self.position.y -= 64;
	elif(walking_direction == 1):
		self.position.x += 64;
	elif(walking_direction == 3):
		self.position.y += 64;
	elif(walking_direction == 4):
		self.position.x -= 64;

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("produce_screen_exited");
