extends Node

export (PackedScene) var audio_record_scene;

var audio_record_A;
var audio_record_B;
var middle_screen;
var wait_b = false;

func _enter_tree():
	$SpawnSceneATimer.wait_time = 0.1;


func _ready():
	middle_screen = get_viewport().size / 2;


func _on_SpawnSceneATimer_timeout():
	audio_record_A = audio_record_scene.instance();
	add_child(audio_record_A);
	if(wait_b):
		remove_child(audio_record_B);
		audio_record_B.queue_free();
	audio_record_A.rect_position = Vector2.ZERO;
	$SpawnSceneBTimer.start();
	$SpawnSceneATimer.wait_time = 4;


func _on_SpawnSceneBTimer_timeout():
	wait_b = true;
	audio_record_B = audio_record_scene.instance();
	add_child(audio_record_B);
	remove_child(audio_record_A);
	audio_record_A.queue_free();
	audio_record_B.rect_position = middle_screen;
	$SpawnSceneATimer.start();
	
