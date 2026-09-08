extends Area2D

class_name Door

@export var next_level: String = ""  # (String, FILE, "*.tscn")

@export var hoverText = ""

var onDoor = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = hoverText
	pass # Replace with function body.

func _on_Door_body_entered(body):
	if body is Player:
		$Label.visible = true
		onDoor = true
	

func _input(event):
	
	if event.is_action_pressed("ui_accept") && onDoor:
		onDoor = false
		get_tree().change_scene_to_file(next_level)
		print("oo")
	else:
		pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Door_body_exited(_body):
	$Label.visible = false
	onDoor = false
