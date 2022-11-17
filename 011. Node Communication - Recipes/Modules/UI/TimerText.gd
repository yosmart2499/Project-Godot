extends Control

signal timer_gone(node_name);

func _ready():
	self.connect("timer_gone", self.owner, "every_timer_gone")

func activate_timer():
	$TimerCountdown.start();
	$TimerAnimation.current_animation = "timer";

func _on_TimerCountdown_timeout():
	$TimerLabel.text = "Bye Bye";
	yield(get_tree().create_timer(1), "timeout");
	self.queue_free();
	self.emit_signal("timer_gone", self.name);
