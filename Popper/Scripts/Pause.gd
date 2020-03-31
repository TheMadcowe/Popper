extends Control

onready var resume = $CenterContainer/VBoxContainer/Resume
onready var exit = $CenterContainer/VBoxContainer/ExitLevel
onready var quit = $CenterContainer/VBoxContainer/Quit

func _ready():
	resume.grab_focus()
	
func _process(delta):

	if resume.is_hovered():
		resume.grab_focus()
	if exit.is_hovered():
		exit.grab_focus()
	if quit.is_hovered():
		quit.grab_focus()

func _input(event):
	if event.is_action_pressed("pause"):
		_pauseUnpause()

func _pauseUnpause():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	print("cheese")
	resume.grab_focus()

func _on_Resume_pressed():
	_pauseUnpause()
	pass # Replace with function body.


func _on_ExitLevel_pressed():
	get_tree().change_scene("res://Stages/Main.tscn")
	get_tree().paused = false
	visible = false
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
