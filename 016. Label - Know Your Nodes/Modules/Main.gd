extends Control

var second: float = 0;

func _process(delta):
	second += (delta * 0.5);
	second = wrapf(second, 0, 1.15);
	$Label.percent_visible = second;
	print($Label.percent_visible);
