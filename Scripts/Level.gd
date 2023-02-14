extends Node

onready var objects = $Objects
# Declare member variables here. Examples:
# var a = 2
# var b = "text"	var balloon = load("res://Balloon.tscn")

onready var coin = load("res://Objects/Coin.tscn")
# cellv 1 = coin
onready var player = load("res://Player/Player.tscn")
onready var balloon = load("res://Objects/Balloon.tscn")
# cellv 0 = balloon
onready var smile = load("res://Objects/Smile.tscn")
onready var bigBalloon = load("res://Objects/Big_Balloon.tscn")
# cellv 3 = smile
onready var gridSize = objects.cell_size

export var winHeight = -300
export var loseHeight = 300

onready var playerPosition = $Player_Spawn
var finished = false

var remainingBalloons = 0
# Called when the node enters the scene tree for the first time.
func _ready():

	var player_instance = player.instance()
	player_instance.set_name("Player")
	add_child(player_instance)
	player_instance.position = playerPosition.position
	addObjects()
	remainingBalloons = get_tree().get_nodes_in_group("Balloons").size()
	$Player.setRemaining(remainingBalloons)
	
	pass # Replace with function body.

func _physics_process(delta):
	if $Player.position.y < winHeight:
		$Player/HUD.youWin()
		finished = true
		$Player._levelWon()
	if $Player.position.y > loseHeight:
		get_tree().change_scene("res://Stages/Main.tscn")
	pass;

func _input(event):
	if get_tree().paused == true:
		if event.is_action_pressed("ui_select"):
			get_tree().paused == false
			get_tree().change_scene("res://Stages/Main.tscn")
			

func addObjects():
	
	var usedCells = objects.get_used_cells()
	print(usedCells)
	
	for i in usedCells.size():
		
		var object = objects.get_cellv(usedCells[i])
		print(object)
		if object == 0 :
			var balloon_instance = balloon.instance()
		
			
			
			
			add_child(balloon_instance)
			balloon_instance.add_to_group("Balloons")
			balloon_instance.position = objects.map_to_world(usedCells[i])
			
			
		elif object == 1 :
			var coin_instance = coin.instance()
			add_child(coin_instance)
			coin_instance.add_to_group("Coins")
			coin_instance.position = objects.map_to_world(usedCells[i])
			
			
		elif object == 3 :
			var smile_instance = smile.instance()
			add_child(smile_instance)
			smile_instance.add_to_group("Balloons")
			smile_instance.position = objects.map_to_world(usedCells[i])
			
		elif object == 4 :
			var big_balloon_instance = bigBalloon.instance()
			add_child(big_balloon_instance)
			big_balloon_instance.add_to_group("Balloons")
			big_balloon_instance.position = objects.map_to_world(usedCells[i])
	objects.clear()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
