extends Area2D

class_name Balloon

var popped = false

export var jumpBoost = 80
# Called when the node enters the scene tree for the first time.
func _ready():
	$Anim.play("idle")
	pass # Replace with function body.
	add_to_group("Balloons")




func _on_Balloon_body_entered(body):
	if not popped and body is Player:
		($Anim as AnimationPlayer).play("pop")
		popped = true
		body.boostJump(jumpBoost)
