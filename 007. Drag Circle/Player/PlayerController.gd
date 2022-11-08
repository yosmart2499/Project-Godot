extends Node

export (PackedScene) var shape_scene;

signal won_game;

var start_number_spaces: Dictionary;
var screen_size: Vector2;
var no_spawn = false;
var number_spaces: Dictionary = {
	"circle" : 0,
	"square" : 0,
	"rectangle" : 0,
};
var start_touched: bool = false;
var end_touched: bool = false;


func _ready():
	screen_size = get_viewport().size;

func _process(_delta):
	if(start_touched && end_touched):
		emit_signal("won_game");
		print("You Win The Game");

func give_spaces(amount: Array):
	number_spaces.circle = amount[0];
	number_spaces.square = amount[1];
	number_spaces.rectangle = amount[2];
	start_number_spaces = number_spaces.duplicate();
	update_label_text()


func update_label_text():
	$ChooseMenu/ShapeContainer/CircleContainer/CircleLabel.text = "{0} x ".format([number_spaces.circle]);
	$ChooseMenu/ShapeContainer/SquareContainer/SquareLabel.text = "{0} x ".format([number_spaces.square]);
	$ChooseMenu/ShapeContainer/RectContainer/RectLabel.text = "{0} x ".format([number_spaces.rectangle]);
	
"""
Learn this.
#func _unhandled_input(event):
#	pass;
Remember _input() first gui input second _unhandled_input() third and then area2d and all the nodes,
"""
func _unhandled_input(event):
	if(no_spawn):
		return;
	if(event is InputEventMouseButton):
		if(event.button_index == BUTTON_RIGHT && event.pressed):
			if($ChooseMenu/ShapeContainer/CircleContainer/CircleButton.disabled && number_spaces.circle > 0):
				var spawn_location = get_viewport().get_mouse_position();
				var shape = shape_scene.instance();
				shape.position = spawn_location;
				shape.create_circle_shape();
				number_spaces.circle -= 1;
				update_label_text();
				self.add_child(shape);
				shape.connect("start_touched", self, "start_touched_catcher");
				shape.connect("end_touched", self, "end_touched_catcher");
			if($ChooseMenu/ShapeContainer/SquareContainer/SquareButton.disabled && number_spaces.square > 0):
				var spawn_location = get_viewport().get_mouse_position();
				var shape = shape_scene.instance();
				shape.position = spawn_location;
				shape.create_rectangle_shape(Vector2(1,1));
				number_spaces.square -= 1;
				update_label_text();
				self.add_child(shape);
				shape.connect("start_touched", self, "start_touched_catcher");
				shape.connect("end_touched", self, "end_touched_catcher");
			if($ChooseMenu/ShapeContainer/RectContainer/RectButton.disabled && number_spaces.rectangle > 0):
				var spawn_location = get_viewport().get_mouse_position();
				var shape = shape_scene.instance();
				shape.position = spawn_location;
				shape.create_rectangle_shape(Vector2(2,0.5));
				number_spaces.rectangle -= 1;
				update_label_text();
				self.add_child(shape);
				shape.connect("start_touched", self, "start_touched_catcher");
				shape.connect("end_touched", self, "end_touched_catcher");


func start_touched_catcher():
	start_touched = true;
	pass;


func end_touched_catcher():
	end_touched = true;
	pass;


func _on_Circle_pressed():
	$ChooseMenu/ShapeContainer/CircleContainer/CircleButton.disabled = true;
	$ChooseMenu/ShapeContainer/SquareContainer/SquareButton.disabled = false;
	$ChooseMenu/ShapeContainer/RectContainer/RectButton.disabled = false;


func _on_Square_pressed():
	$ChooseMenu/ShapeContainer/CircleContainer/CircleButton.disabled = false;
	$ChooseMenu/ShapeContainer/SquareContainer/SquareButton.disabled = true;
	$ChooseMenu/ShapeContainer/RectContainer/RectButton.disabled = false;


func _on_Rectangle_pressed():
	$ChooseMenu/ShapeContainer/CircleContainer/CircleButton.disabled = false;
	$ChooseMenu/ShapeContainer/SquareContainer/SquareButton.disabled = false;
	$ChooseMenu/ShapeContainer/RectContainer/RectButton.disabled = true;


func _on_NoSpawnArea_mouse_entered():
	no_spawn = true;


func _on_NoSpawnArea_mouse_exited():
	no_spawn = false;


func _on_ResetButton_pressed():
	number_spaces = start_number_spaces.duplicate();
	update_label_text();
	get_tree().call_group("shapes", "queue_free");


# Start Turn Green
func _on_StartArea_area_entered(area):
	if("Shape" in area.name):
		$Start/StartBackground.color = Color(0.564706, 1, 0.501961);

# Start Turn Yellow
func _on_StartArea_area_exited(area):
	if("Shape" in area.name):
		$Start/StartBackground.color = Color(0.972549, 1, 0.501961);

# End Turn Green
func _on_EndArea_area_entered(area):
	if("Shape" in area.name):
		$End/EndBackground.color = Color(0.564706, 1, 0.501961);

# End Turn Red
func _on_EndArea_area_exited(area):
	if("Shape" in area.name):
		$End/EndBackground.color = Color(1, 0.501961, 0.584314);


func _on_ResetTimer_timeout():
	start_touched = false;
	end_touched = false;
