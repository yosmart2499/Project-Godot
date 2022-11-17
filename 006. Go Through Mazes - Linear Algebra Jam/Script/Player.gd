extends Area2D

var velocity;
var screen_size;

signal game_over;

func _ready():
	screen_size = get_viewport().size;
	velocity = Vector2.ZERO;
	
	start_pos();
	toggle_visible_player();

func start_pos():
	self.position.x = int(screen_size.x/64) * 64;
	self.position.y = int(screen_size.y/64) * 64;
	self.position -= Vector2(32,32);

func toggle_visible_player():
	self.visible = !self.visible;
	
func update_move(vector):
	var tween = Tween.new();
	tween.interpolate_property(self, "position", self.position,  self.position + vector, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
	add_child(tween);
	tween.start();
	yield(tween, "tween_all_completed");
	tween.queue_free();
#	self.position += vector;

func _on_Player_body_entered(_body):
	hide();
	emit_signal("game_over");
	yield(get_tree().create_timer(2), "timeout");
	start_pos();

func _on_PrintoutTimer_timeout():
#	print(self.position);
	pass;
