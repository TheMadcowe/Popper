extends CharacterBody2D

class_name  NPC

@onready var text = $Label

@export var speech = ""

const WALKING_SPEED = 10
const GRAVITY_VECTOR = Vector2(0,200)
const FLOOR_NORMAL = Vector2(0,-1)
const SLOPE_SLIDE_STOP = 0.25

var direction = 1

var linear_vel = Vector2()

var targetDirection = 0

var anim = ""



func _physics_process(_delta):
	var new_anim = "Idle"
	linear_vel += _delta * GRAVITY_VECTOR
	linear_vel.x = direction * WALKING_SPEED
	
	set_velocity(linear_vel)
	set_up_direction(FLOOR_NORMAL)
	set_floor_stop_on_slope_enabled(SLOPE_SLIDE_STOP)
	move_and_slide()
	linear_vel = velocity
	
	if direction == 0:
		new_anim = "Idle"
	elif(linear_vel.x != 0):
		$Sprite2D.scale = Vector2(direction, 1)
		new_anim = "Walk"

	
	if new_anim != anim:
		anim = new_anim
		($Anim as AnimationPlayer).play(anim)
		print(anim)
	


func _on_Timer_timeout():
	direction = randi() % 3 - 1
	$Timer.wait_time = randi() % 3 + 1



func _on_Area2D_body_entered(body):
	if body is Player:
		text.visible = true
		text.text = speech


func _on_Area2D_body_exited(body):
	if body is Player:
		text.visible = false
