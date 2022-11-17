extends ProgressBar

export var impulses_component: Resource = preload("res://Assets/Resources/impulses_component.tres");

func _ready() -> void:
	print(self.impulses_component.connect("impulses_changed", self, "bar_change_impulses"));
	self.min_value = self.impulses_component.min_val;
	self.max_value = self.impulses_component.max_val;
	self.step = self.impulses_component.step_val;

func bar_change_impulses() -> void:
	self.value = self.impulses_component.value;
