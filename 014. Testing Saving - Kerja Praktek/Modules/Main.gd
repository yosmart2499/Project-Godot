extends Node

var costum_repo; # Must be variant to be able to save succesfully
var file_path: String = "user://costum_save.save";

"""
 This save replace the save sample
	for i in range(10):
		costum_repo.costum_array.append(CostumObject.new(String(i), String(9 - i)));
	SavingLoading.save_to_file(file_path, costum_repo);
	for object in SavingLoading.load_from_file(file_path).costum_array:
		print(object.text, " - ", object.type);
"""

func _ready() -> void:
	costum_repo = SavingLoading.load_from_file(file_path);
	if(costum_repo == null):
		costum_repo = CostumRepo.new();
	print(costum_repo.costum_sample_array);

func _on_SpellingSoundHBoxContainer_recorded_spelling(recording: AudioStreamSample) -> void:
	var temp_costum_object: CostumObject = CostumObject.new();
	temp_costum_object.sample = recording;
	costum_repo.costum_sample_array.append(temp_costum_object);
	SavingLoading.save_to_file(file_path, costum_repo);

func _on_PlaySaved_pressed():
	if(SavingLoading.load_from_file(file_path) == null):
		return;
	for object in SavingLoading.load_from_file(file_path).costum_sample_array:
		$SamplePlayer.stream = object.sample;
		$SamplePlayer.volume_db = 40;
		$SamplePlayer.play();
		yield($SamplePlayer, "finished");
		yield(get_tree().create_timer(0.3), "timeout");
