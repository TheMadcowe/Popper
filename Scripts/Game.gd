extends Node

enum PlayerState { IDLE, WALK, JUMP, DOUBLE_JUMP, STOMP }
enum BalloonType { RED, GREEN, BLUE, PURPLE, GOLD }

const OBJECTS = {
	"balloon": {"scene": preload("res://Objects/Balloon.tscn"), "group": "Balloons"},
	"coin": {"scene": preload("res://Objects/Coin.tscn"), "group": "Coins"},
	"smile": {"scene": preload("res://Objects/Smile.tscn"), "group": "Balloons"},
	"big_balloon": {"scene": preload("res://Objects/Big_Balloon.tscn"), "group": "Balloons"}
}

# Global counters
var total_balloon_hp = 0
var total_coins = 0

signal balloon_popped(damage)
signal coin_collected(amount)

# Called by balloons
func on_balloon_popped(damage=1):
	total_balloon_hp = max(total_balloon_hp - damage, 0)
	emit_signal("balloon_popped", damage)

# Called by coins
func on_coin_collected(amount=1):
	total_coins += amount
	emit_signal("coin_collected", amount)

# Reset balloon HP at start of level
func reset_level_balloon_hp(count):
	total_balloon_hp = count
	emit_signal("balloon_popped", 0) # Refresh HUD
