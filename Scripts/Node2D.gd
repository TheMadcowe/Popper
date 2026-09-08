extends RigidBody2D

class_name NAIL

func _physics_process(_delta):
	pass;

func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
