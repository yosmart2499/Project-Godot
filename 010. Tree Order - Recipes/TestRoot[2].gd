extends Node

export (PackedScene) var instance_root_scene;


func _init():
	print("TestRoot init");

func _enter_tree():
	print(self.name + " ----- enter tree");
	var instance = instance_root_scene.instance();
	self.add_child(instance);

func _ready():
	print(self.name + " ----- ready");


var called_once_process: bool = false;
func _process(_delta):
	if(called_once_process):
		return;
	called_once_process = true;
	print(self.name + " ----- process");

var called_once_physics: bool = false;
func _physics_process(_delta):
	if(called_once_physics):
		return;
	called_once_physics = true;
	print(self.name + " ----- physics process");



