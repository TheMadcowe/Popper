extends Area2D

class_name Coin

var coinSounds=[]

var taken = false

var coinValue = 1

func _ready():
	coinSounds.append(preload("res://Audio/coin_sounds/coin1.wav"))
	coinSounds.append(preload("res://Audio/coin_sounds/coin2.wav"))
	coinSounds.append(preload("res://Audio/coin_sounds/coin3.wav"))
	coinSounds.append(preload("res://Audio/coin_sounds/coin10.wav"))

func _on_Coin_body_entered(body):
	if not taken and body is Player:
		taken = true
		($Anim as AnimationPlayer).play("taken")
		_playSound()
		Game.on_coin_collected(coinValue)

func _playSound():
	var sound = randi() % coinSounds.size()
	$Audio.stream = coinSounds[sound]
	$Audio.play()
