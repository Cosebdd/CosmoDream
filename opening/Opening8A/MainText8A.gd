extends RichTextLabel


func _ready():
	$Tween.interpolate_property(
		self, "percent_visible", 
		0.0, 1.0, 6.0, Tween.TRANS_LINEAR
	)
	$Tween.start()
