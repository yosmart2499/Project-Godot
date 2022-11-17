extends ColorRect


func _on_DotTimer_timeout():
	$LoadingLabel.text += ".";
	if($LoadingLabel.text == "Loading...."):
		$LoadingLabel.text = "Loading";
	if(not self.visible):
		$DotTimer.stop();
