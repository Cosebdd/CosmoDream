extends Camera2D
var velocity = 2

func _process(delta):
	self.position.x = self.position.x - delta*velocity
	self.position.y = self.position.y - delta*velocity
