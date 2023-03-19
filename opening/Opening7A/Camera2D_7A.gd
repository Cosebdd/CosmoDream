extends Camera2D
var velocity = 4

func _process(delta):
	self.position.y = self.position.y - delta*velocity
