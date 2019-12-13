extends Area2D

class_name Coin

var taken = false

func _on_Coin_body_entered(body):
	if not taken and body is Player:
		($Anim as AnimationPlayer).play("taken")
		taken = true
