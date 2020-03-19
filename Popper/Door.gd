extends Area2D

class_name Door

export(String, FILE, "*.tscn") var next_level 

export var hoverText = ""

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = hoverText
	pass # Replace with function body.

func _on_Door_body_entered(body):
	if body is Player:
		$Label.visible = true
	
	
	if Input.is_key_pressed(KEY_F):
		get_tree().change_scene(next_level)
		print("oo")
		pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Door_body_exited(body):
	$Label.visible = false
