extends Node2D

var enemy1 = load("res://Enemy.tscn")
var enemy2 = load("res://Enemy2.tscn")
onready var timer = get_node("Timer")
var toggle = true
var enemies = []


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if timer.is_stopped():
		spawn()
		timer.start()

func spawn():
	var currentEnemy
	if toggle:
		currentEnemy = enemy1.instance()
		toggle = !toggle
	else:
		currentEnemy = enemy2.instance()
		toggle = !toggle
	currentEnemy.position = Vector2(rand_range(30, 570), position.y)
	get_parent().add_child(currentEnemy)
	enemies.append(currentEnemy)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	timer.stop()
