extends Node

onready var objects = $Objects
# Declare member variables here. Examples:
# var a = 2
# var b = "text"	var balloon = load("res://Balloon.tscn")

onready var coin = load("res://Coin.tscn")
# cellv 1 = coin
onready var player = load("res://Player.tscn")
onready var balloon = load("res://Balloon.tscn")
# cellv 0 = balloon
onready var gridSize = objects.cell_size

var remainingBalloons = 0
# Called when the node enters the scene tree for the first time.
func _ready():

	var player_instance = player.instance()
	player_instance.set_name("Player")
	add_child(player_instance)
	addObjects()
	remainingBalloons = get_tree().get_nodes_in_group("Balloons").size()
	$Player.setRemaining(remainingBalloons)
	
	pass # Replace with function body.

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
			print(balloon_instance.position)
			
		elif object == 1 :
			var coin_instance = coin.instance()
		
			
			
			
			add_child(coin_instance)
			coin_instance.add_to_group("Coins")
			coin_instance.position = objects.map_to_world(usedCells[i])
			print(coin_instance.position)
	objects.clear()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
