extends KinematicBody2D

class_name Player

const GRAVITY_VECTOR = Vector2(0, 200)
const FLOOR_NORMAL = Vector2(0,-1)
const WALKING_SPEED = 56
const JUMP_HEIGHT = 80
const SLOPE_SLIDE_STOP = 0.25
const SIDING_CHANGE_SPEED = 10
const SIZE = 1
const MAX_FALL_SPEED = 120
const NAIL_SPEED = 70

export var totalJumps = 1
var jumps = totalJumps

onready var sprite = $Sprite
var Nail = preload("res://Player/Nail.tscn")

var shoot_time = 0.04
var burst = 3
var shooting = false

var levelWon = false

var combo = 0
var currentPitch = 0.8

var linear_vel = Vector2()

var anim = ""

var coins = 0

var remainingBalloons = 0


func _ready():
	sprite.scale.y = SIZE
	sprite.scale.x = SIZE
	$CollisionShape2D.scale.x = SIZE
	$CollisionShape2D.scale.y = SIZE
	
	$HUD.updateCoins(coins)

func addCoin(coinValue):
	coins += coinValue
	$HUD.updateCoins(coins)
	pass;

func boostJump(jumpBoost):
	linear_vel.y = 0;
	linear_vel.y -= jumpBoost;
	jumps = totalJumps
	combo += 1
	remainingBalloons -= 1
	$HUD.updateRemaining(remainingBalloons)
	$HUD.updateCombo(combo)

	playAudio()

func setRemaining(remaining):
	remainingBalloons = remaining
	$HUD.updateRemaining(remaining)

func playAudio():
	if(currentPitch <= 2):
		currentPitch = 0.8 + combo*0.1
		$SoundEffect.pitch_scale = currentPitch
	$SoundEffect.play()

func _fire_nail():
	shoot_time = 0
	
	shooting = true

	
	
	for i in range(burst):
		var nail = Nail.instance()
		nail.position = ($Sprite/NailShoot as Position2D).global_position
		nail.position.y += (randi() % 5) - 2
		nail.add_collision_exception_with(self)
		nail.linear_velocity = Vector2(sprite.scale.x * NAIL_SPEED, 0)
		nail.scale.x = sprite.scale.x
		get_parent().add_child(nail)
		yield(get_tree().create_timer(.05), "timeout")
	
	shooting = false

	
	pass;



func _physics_process(delta):
	
	if not levelWon:
		linear_vel += delta * GRAVITY_VECTOR
	elif linear_vel.y != 0:
		linear_vel.y = 0
	if(shoot_time < 0.3):
		shoot_time += delta

	var on_floor = is_on_floor()
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	
	var target_speed = 0
	
	if Input.is_action_pressed("ui_left"):
		target_speed -= 1
	if Input.is_action_pressed("ui_right"):
		target_speed += 1
	
	if Input.is_key_pressed(KEY_Z) and shoot_time >= 0.2:
		if(shooting == false):
			_fire_nail()
		
	if Input.is_action_just_pressed("ui_up") and jumps > 0:
		linear_vel.y = -JUMP_HEIGHT
		jumps -= 1
	
	target_speed *= WALKING_SPEED
	
	linear_vel.x = lerp(linear_vel.x, target_speed, 0.1)
	
	if linear_vel.y > MAX_FALL_SPEED:
		linear_vel.y = MAX_FALL_SPEED
	
	var new_anim = "idle"
	
	if on_floor:
		if(combo!= 0):
			combo = 0
			$HUD.updateCombo(combo)
		currentPitch = 0.8
		
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
		
		if linear_vel.y != 0 || levelWon:
			new_anim = "jump"


	if new_anim != anim:
		anim = new_anim
		($Anim as AnimationPlayer).play(anim)
		
		
		

func _levelWon():
	levelWon = true

func _input(event):
	if levelWon && (event.is_action_pressed("ui_up") || event.is_action_pressed("ui_accept")):
		get_tree().change_scene("res://Stages/Main.tscn")
