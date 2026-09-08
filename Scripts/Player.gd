extends CharacterBody2D
class_name Player

signal balloon_hit(balloon, damage)
signal coin_collected(coin, amount)
signal reached_win
signal reached_lose
signal combo_incremented


const GRAVITY_VECTOR = Vector2(0, 200)
const WALKING_SPEED = 56
const JUMP_HEIGHT = 80
const SIZE = 1
const MAX_FALL_SPEED = 120
const NAIL_SPEED = 70


@export var max_air_jumps = 1
var air_jumps_left: int

@onready var sprite: Sprite2D = $Sprite2D
@onready var anim_player: AnimationPlayer = $Anim

var Nail = preload("res://Player/Nail.tscn")

var shoot_time: float = 0.04
var burst: int = 3
var shooting: bool = false

var level_won: bool = false

var combo: int = 0
var currentPitch: float = 0.8

var linear_vel: Vector2 = Vector2.ZERO
var anim: String = ""



func _ready() -> void:
	sprite.scale = Vector2.ONE * SIZE
	$CollisionShape2D.scale = Vector2.ONE * SIZE
	air_jumps_left = max_air_jumps
	

func boost_jump(jump_boost):
	linear_vel.y = 0
	linear_vel.y -= jump_boost;
	air_jumps_left = max_air_jumps
	combo += 1
	currentPitch = 0.8 + combo * 0.1
	
	emit_signal("balloon_hit", self, 1)
	emit_signal("combo_incremented", combo)
	
	if has_node("SoundEffect"):
		$SoundEffect.pitch_scale = currentPitch
		$SoundEffect.play()
	

func _fire_nail():
	if shooting:
		return
	shooting = true
	shoot_time = 0.0
	
	for i in range(burst):
		var nail = Nail.instantiate()
		nail.position = ($Sprite2D/NailShoot as Marker2D).global_position
		nail.add_collision_exception_with(self)
		nail.linear_velocity = Vector2(sprite.scale.x * NAIL_SPEED, 0)
		nail.scale.x = sprite.scale.x
		nail.position.y += (randi() % 5) - 2
		get_parent().add_child(nail)
		await get_tree().create_timer(.05).timeout
	shooting = false

func _physics_process(_delta):
	if not level_won:
		linear_vel.y += GRAVITY_VECTOR.y * _delta
	else:
		linear_vel.y = 0
	
	#linear_vel.y = min(linear_vel.y, MAX_FALL_SPEED)
	
	shoot_time += _delta
	
	# Horizontal Movement
	
	var target_dir := 0.0
		
	if Input.is_action_pressed("move_left"):
		target_dir -= 1
		sprite.scale.x = -SIZE
	if Input.is_action_pressed("move_right"):
		target_dir += 1
		sprite.scale.x = SIZE
	
	linear_vel.x = lerp(linear_vel.x, target_dir * WALKING_SPEED, 0.1)
	
	# Jump
	if Input.is_action_just_pressed("jump") and (is_on_floor() or air_jumps_left > 0):
		linear_vel.y = -JUMP_HEIGHT
		if not is_on_floor():
			air_jumps_left -= 1
	
	# Stomp
	if Input.is_action_just_pressed("stomp") and not is_on_floor():
		linear_vel.y = MAX_FALL_SPEED
	
	# Shoot
	if Input.is_action_just_pressed("shoot"):
		_fire_nail()
		
	if linear_vel.y > MAX_FALL_SPEED:
		linear_vel.y = MAX_FALL_SPEED
	# Movement
	velocity = linear_vel
	move_and_slide()
	linear_vel = velocity
	
	# Animation
	var new_anim = "idle"
	if not is_on_floor() or level_won:
		new_anim = "jump"
	elif abs(linear_vel.x) > 1:
		new_anim = "run"
	if new_anim != anim:
		anim = new_anim
		($Anim as AnimationPlayer).play(anim)
		
	if is_on_floor():
		if combo != 0:
			combo = 0
			emit_signal("combo_incremented", combo)
		currentPitch = 0.8
		air_jumps_left = max_air_jumps

func _level_won():
	level_won = true
	emit_signal("reached_win")
