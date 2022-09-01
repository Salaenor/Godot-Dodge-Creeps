extends Node

export (PackedScene) var mob_scene
var score = 0

func _ready():
	randomize() #ensures numbers are randomized every gameS
	
func new_game():
	score = 0
	$HUD.update_score(score)
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Music.play()
	$HUD.show_message("Get Ready...")
	yield($StartTimer, "timeout") #Makes it so that Scoretimer doesn't start until Start Timer ends
	$ScoreTimer.start()
	$MobTimer.start()
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func _on_MobTimer_timeout():
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.unit_offset = randf()
	
	var mob = mob_scene.instance()
	add_child(mob)
	
	var mob_z_index = rand_range(0, 3)
	mob.z_index = mob_z_index
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI/2 #Turns sprite 90 degrees
	direction += rand_range(-PI/4,PI/4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
