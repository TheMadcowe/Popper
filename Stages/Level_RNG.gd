extends Node

@onready var Map = $TileMap
@export var width := 40
@export var height := 40
var cell_width := 8

var balloon = preload("res://Objects/Balloon.tscn")
var Coin = preload("res://Objects/Coin.tscn")

# 0 = grass, 1 = gold, 2 = iron, 3 = silver, 4 = copper, 5 = sapphire, 6 = dirt

# Called when the node enters the scene tree for the first time.
func _ready():
	for n in width:
		for y in height:
				Map.set_cell(Vector2i(n,y), 6, Vector2i(0,0))
	
	add_Minerals()
	add_Grass()
	add_Objects()
	pass # Replace with function body.

func add_Objects():
	for n in width:
		height = -height
		for y in height:
			var percent = randi() % 100
			if percent > 75:
				var balloo = balloon.instantiate()
				balloo.position = Vector2i(n*cell_width,(-10)+-y*cell_width)
				add_child(balloo)
				
			elif percent > 50 && percent < 75:
				var coin = Coin.instantiate()
				coin.position = Vector2i(n*cell_width,(-10)+-y*cell_width)
				add_child(coin)
				
	Game.emit_signal("balloon_popped", 0)

func add_Minerals():
	for n in width:
		for y in height:
			var percent = randi() % 100
			if percent > 75:
				var mineral = randi() % 5 +1
				Map.set_cell(Vector2(n,y), mineral, Vector2i(0,0))

func add_Grass():
	for n in width:
		Map.set_cell(Vector2(n,0), 0, Vector2i(0,0))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
