extends CanvasLayer

var waiting_letter_reset;

func _ready():
	$KeyboardWaitingInputTimer.start();
	waiting_letter_reset = false;

func change_wordlabel(text):
	$WordLabel.text = text;
	$KeyboardWaitingInputTimer.stop();

func _on_KeyboardWaitingInputTimer_timeout():
	if(waiting_letter_reset):
		waiting_letter_reset = false;
		yield(get_tree().create_timer(2), "timeout");
		$KeyboardWaitingInputTimer.start();
		return;
	$WordLabel.text += "|";
	yield(get_tree().create_timer(1), "timeout");
	$WordLabel.text = $WordLabel.text.replace("|", "");
	$KeyboardWaitingInputTimer.start();
