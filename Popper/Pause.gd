extends Control


func _ready():
	$CenterContainer/VBoxContainer/Resume.grab_focus()
	
func _process(delta):
	var resume = $CenterContainer/VBoxContainer/Resume
	var exit = $CenterContainer/VBoxContainer/ExitLevel
	var quit = $CenterContainer/VBoxContainer/Quit
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

func _on_Resume_pressed():
	_pauseUnpause()
	pass # Replace with function body.


func _on_ExitLevel_pressed():
	get_tree().change_scene("res://Main.tscn")
	get_tree().paused = false
	visible = false
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
