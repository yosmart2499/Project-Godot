extends Resource
class_name ImpulsesComponent

export var max_val: int = 1000;
export var min_val: int = 100;
export var step_val: int = 30;
export var reduce_val: float = 0.1;

var value: int = min_val;
var bounce: bool = false;

signal impulses_changed();

func reduce_impulses() -> void:
	self.value = int(max(self.min_val, self.value - self.step_val * self.reduce_val));
	self.emit_signal("impulses_changed");

func add_impulses() -> void:
	if(not self.bounce):
		self.value = int(min(self.value + self.step_val, self.max_val));
		if(self.value == self.max_val):
			self.bounce = true;
	else:
		self.value = int(max(self.value - self.step_val, self.min_val));
		if(self.value == self.min_val):
			self.bounce = false;
	self.emit_signal("impulses_changed");

func reset_impulses() -> void:
	self.value = self.min_val;
	self.bounce = false;
	self.emit_signal("impulses_changed");
