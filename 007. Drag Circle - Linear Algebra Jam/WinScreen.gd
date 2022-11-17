extends Control

func start_reloading():
	$ReloadTimer.start();
	self.show();

func _on_ReloadTimer_timeout():
	get_tree().reload_current_scene();
