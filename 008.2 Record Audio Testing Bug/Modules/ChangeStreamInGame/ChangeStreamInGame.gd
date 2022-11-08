extends Node

var ingame_sample: AudioStreamSample;

func _ready():
	change_ingame_sample("user://Treasure.wav");

func change_ingame_sample(path: String):
	var sound_data: File = File.new();
	sound_data.open(path, File.READ);
	var buffer = sound_data.get_buffer(sound_data.get_len());
	ingame_sample = AudioStreamSample.new();
	for i in range(200):
		buffer.remove(buffer.size()-1);
		buffer.remove(0);
	ingame_sample.data = buffer;
	ingame_sample.format = 1;
	ingame_sample.mix_rate = 44100;
	ingame_sample.stereo = true;
	sound_data.close();


func _on_PlayButton_pressed():
	$AudioStreamPlayer.stream = ingame_sample;
	$AudioStreamPlayer.volume_db = 30;
	$AudioStreamPlayer.play();


func _on_ChangeStreamTimer_timeout():
	change_ingame_sample("user://Halo Kenobi.wav");
	$PlayButton.modulate = Color.green;
