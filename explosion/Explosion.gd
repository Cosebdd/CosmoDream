extends Node2D

onready var explosion_sprites = $ExplosionSprites

func _ready():
	randomize()
	var children = explosion_sprites.get_children()
	var rand_index:int = randi() % children.size()
	var explosion_sprite = children[rand_index] as AnimatedSprite
	explosion_sprite.visible = true
	explosion_sprite.play()
	explosion_sprite.connect("animation_finished", self, "destroy_self")

func destroy_self() -> void:
	queue_free()

