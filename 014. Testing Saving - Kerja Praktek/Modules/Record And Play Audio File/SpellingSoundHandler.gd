extends HBoxContainer

var effect: AudioEffect;
var recording: AudioStreamSample;

signal recorded_spelling(recording);

func _ready():
	var idx: int = AudioServer.get_bus_index("Record");
	effect = AudioServer.get_bus_effect(idx, 0);

func _on_RecordButton_pressed():
	if(effect.is_recording_active()):
		recording = effect.get_recording();
		effect.set_recording_active(false);
		$RecordButton.text = "Record";
		$PlayButton.disabled = false;
		$SpellingAudioStreamPlayer.stop();
		emit_signal("recorded_spelling", recording);
	else:
		effect.set_recording_active(true);
		$RecordButton.text = "Stop";
		$PlayButton.disabled = true;

func _on_PlayButton_pressed():
	$SpellingAudioStreamPlayer.stream = recording;
	$SpellingAudioStreamPlayer.volume_db = 40;
	$SpellingAudioStreamPlayer.play();
