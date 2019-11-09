extends KinematicBody2D

const GRAVITY_VECTOR = Vector2(0, 300)
const FLOOR_NORMAL = Vector2(0,-1)
const WALKING_SPEED = 75
const JUMP_HEIGHT = 125
const SLOPE_SLIDE_STOP = 0.25
const SIDING_CHANGE_SPEED = 10
const SIZE = 1
const MAX_FALL_SPEED = 150


export var totalJumps = 1
var jumps = totalJumps

onready var sprite = $Sprite


var linear_vel = Vector2()

var anim = ""

func _ready():
	sprite.scale.y = SIZE
	sprite.scale.x = SIZE
	$CollisionShape2D.scale.x = SIZE
	$CollisionShape2D.scale.y = SIZE

func _physics_process(delta):
	linear_vel += delta * GRAVITY_VECTOR
	
	var on_floor = is_on_floor()
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	
	var target_speed = 0
	
	if Input.is_action_pressed("ui_left"):
		target_speed -= 1
		print(target_speed, linear_vel.x)
	if Input.is_action_pressed("ui_right"):
		target_speed += 1
		print(target_speed, linear_vel)
		
	if Input.is_action_just_pressed("ui_up") and jumps > 0:
		linear_vel.y = -JUMP_HEIGHT
		jumps -= 1
	
	target_speed *= WALKING_SPEED
	
	linear_vel.x = lerp(linear_vel.x, target_speed, 0.1)
	
	if linear_vel.y > MAX_FALL_SPEED:
		linear_vel.y = MAX_FALL_SPEED
	
	var new_anim = "idle"
	
	if on_floor:
		
		
		if(linear_vel.x < -SIDING_CHANGE_SPEED):
			sprite.scale.x = -SIZE
			new_anim = "run"
		if(linear_vel.x > SIDING_CHANGE_SPEED):
			sprite.scale.x = SIZE
			new_anim = "run"
		jumps = totalJumps
		
	else:
		
		if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
			sprite.scale.x = -SIZE
		if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
			sprite.scale.x = SIZE
		
		if linear_vel.y != 0:
			new_anim = "jump"


	if new_anim != anim:
		anim = new_anim
		($Anim as AnimationPlayer).play(anim)