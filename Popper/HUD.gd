extends CanvasLayer

onready var comboText = $ComboText
onready var remainingText = $RemainingText
onready var coinsText = $CoinsText

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func updateCombo(combo):
	comboText.text = "Combo: " + str(combo)+"x"
	
#	comboText.margin_bottom = (randi() % 100)
#	comboText.margin_left = (randi() % 100)
#	comboText.margin_top = (randi() % 100)
#	comboText.margin_right = (randi() % 100)

	pass # Replace with function body.
	
func updateRemaining(remaining):
	remainingText.text = "Remaining: " + str(remaining)

func updateCoins(coins):
	coinsText.text = "Coins: " + str(coins)
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
