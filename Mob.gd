extends RigidBody2D

export var min_speed = 150.0
export var max_speed = 250.0

func _ready():
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names() #array of animation names
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()] #currently playing animation 


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
