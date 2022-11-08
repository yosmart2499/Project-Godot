extends Node2D

signal send_word(word);
signal letters_touched(letters);

var wait_time = false;
var touched_letters = "";
var touch_time = 1;

func _ready():
	self.hide();
	self.scale = Vector2(3,3);

func _input(event):
	if(wait_time):
		return;
	if(event is InputEventScreenDrag):
		if($AreaDragScreenRIGHT.is_on_area()):
			touched_letters += $AreaDragScreenRIGHT/Label.text;
			emit_signal("letters_touched", touched_letters);
			$AreaDragScreenRIGHT.toggle_functionality();
			yield(get_tree().create_timer(touch_time),"timeout");
			$AreaDragScreenRIGHT.toggle_functionality();
		if($AreaDragScreenLEFT.is_on_area()):
			touched_letters += $AreaDragScreenLEFT/Label.text;
			emit_signal("letters_touched", touched_letters);
			$AreaDragScreenLEFT.toggle_functionality();
			yield(get_tree().create_timer(touch_time),"timeout");
			$AreaDragScreenLEFT.toggle_functionality();
		if($AreaDragScreenUP.is_on_area()):
			touched_letters += $AreaDragScreenUP/Label.text;
			emit_signal("letters_touched", touched_letters);
			$AreaDragScreenUP.toggle_functionality();
			yield(get_tree().create_timer(touch_time),"timeout");
			$AreaDragScreenUP.toggle_functionality();
		if($AreaDragScreenDOWN.is_on_area()):
			touched_letters += $AreaDragScreenDOWN/Label.text;
			emit_signal("letters_touched", touched_letters);
			$AreaDragScreenDOWN.toggle_functionality();
			yield(get_tree().create_timer(touch_time),"timeout");
			$AreaDragScreenDOWN.toggle_functionality();
	if(event is InputEventMouseButton && event.is_pressed() == false):
		wait_time = true;
		emit_signal("send_word", touched_letters);
		yield(get_tree().create_timer(1), "timeout");
		wait_time = false;
		touched_letters = "";

func change_letters(bunch_letters):
	$AreaDragScreenRIGHT/Label.text = bunch_letters[0];
	$AreaDragScreenLEFT/Label.text = bunch_letters[1];
	$AreaDragScreenUP/Label.text = bunch_letters[2];
	$AreaDragScreenDOWN/Label.text = bunch_letters[3];
