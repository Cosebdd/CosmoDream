extends Camera2D
var velocity = 3.5

func _process(delta):
	self.position.y = self.position.y - delta*velocity
