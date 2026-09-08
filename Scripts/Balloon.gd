extends Area2D
class_name Balloon

var popped = false

@export var jumpBoost = 80
@export var hp = 1

func _ready():
	$Anim.play("idle")
	add_to_group("Balloons")

func _on_Balloon_body_entered(body):
	if popped:
		return
	if body is Player or NAIL:
		hp -= 1
		($Anim as AnimationPlayer).play("pop")
		Game.on_balloon_popped(1)
		if body is Player:
			body.boost_jump(jumpBoost)
		if hp <= 0:
			popped = true





func _on_animation_finished(anim_name):
	if anim_name == "pop" and hp <= 0:
		queue_free()
	pass # Replace with function body.
