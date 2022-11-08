extends Node

export (PackedScene) var junk_scene;

var movement_perpixel: Vector2;
var time_passed: float = 0;
var target_fps: int = 30;

onready var screen_size: Vector2 = get_viewport().size;
onready var start_pos: Vector2 = Vector2(0, screen_size.y / 2);

func convert_time_passed() -> String:
	return ("Time: " + String(stepify(time_passed, 0.1)));


func _ready():
	Engine.target_fps = target_fps;
	$IndicatorSprite.position = start_pos;
	$Pivot/RecordedTime.text = convert_time_passed();

func _process(delta: float) -> void:
	$Pivot/FPSLabel.text = "FPS: " + String(Engine.get_frames_per_second());
	if($Pivot/DeltaSwitch.pressed):
		movement_perpixel = Vector2(screen_size.x/5,0);
		$IndicatorSprite.position += movement_perpixel * delta;
	else:
		movement_perpixel = Vector2(screen_size.x/5/60, 0);
		$IndicatorSprite.position += movement_perpixel;


func _physics_process(delta):
	time_passed += delta;
	$Pivot/TimeLabel.text = convert_time_passed();

func _on_VisibilityNotifier2D_screen_exited():
	$Pivot/RecordedTime.text = convert_time_passed();
	time_passed = 0;
	$Pivot/TimeLabel.text = convert_time_passed();
	$IndicatorSprite.position = start_pos;


func _on_SpawnJunk_timeout():
	for i in range(500):
		var junk: Node2D = junk_scene.instance();
		self.add_child(junk);
