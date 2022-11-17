extends HBoxContainer

onready var effect: AudioEffectRecord  = AudioServer.get_bus_effect(AudioServer.get_bus_index("Record"), 0);

signal recorded_spelling(recording);

func _on_RecordButton_pressed():
	if(effect.is_recording_active()):
		$SpellingAudioStreamPlayer.stream  = effect.get_recording();
		effect.set_recording_active(false);
		$RecordButton.text = "Record";
		$PlayButton.disabled = false;
		$SpellingAudioStreamPlayer.stop();
		emit_signal("recorded_spelling", $SpellingAudioStreamPlayer.stream);
	else:
		effect.set_recording_active(true);
		$RecordButton.text = "Stop";
		$PlayButton.disabled = true;

func _on_PlayButton_pressed():
	$SpellingAudioStreamPlayer.volume_db = 40;
	$SpellingAudioStreamPlayer.play();

"""
Remember when emitting a signal the recording is still audio stream not .wav
So in the input UI make sure after submit save the audio stream with save_to_wav() function

Still the same. Branched folder doesn't works.
recording.save_to_wav("user://Test/Sound/test_sample.wav");

recording.save_to_wav("user://test_sample.wav"); # Works

ABORT! ABORT! ABORT!
In the demo is the same! It can't create nested folder. save_to_wav() function only works when creating the file name.
Not the folder. So keep that in mind!
ALWAYS MAKE SURE ERROR IN DEBUGGING IS THE SAME ERROR IN YOUR MIND!!!
Because apparently I do not open the debugger when using nested folder.

recording.save_to_wav("user://Test/Sound/test_sample.wav");  # Doesn't work because save_to_wave() not build for that.

E 0:00:02.118   save_to_wav: Condition "!file" is true. Returned: ERR_FILE_CANT_WRITE
  <C++ Source>  scene/resources/audio_stream_sample.cpp:550 @ save_to_wav()
  <Stack Trace> SpellingSoundHandler.gd:30 @ _on_RecordButton_pressed()
"""
