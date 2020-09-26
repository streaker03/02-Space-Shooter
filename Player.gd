extends KinematicBody2D

export (int) var speed = 200
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bullet = load("res://Bullet.tscn")
var velocity = Vector2()
onready var timer = get_node("Timer")
onready var power = get_node("Timer2")
onready var spawner = get_parent().get_child(4)
onready var powerLabel = get_node("Power")
onready var score = get_parent().get_child(2)

# Called when the node enters the scene tree for the first time.
func _ready():
	power.start() # Replace with function body.

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Right"):
		velocity.x += 1
	if Input.is_action_pressed("Shoot") and timer.is_stopped():
		_shoot()
		timer.start()
	if Input.is_action_pressed("power") and power.is_stopped():
		power()
		power.start()
	velocity = velocity.normalized() * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	if get_slide_count() > 0:
		get_parent().remove_child(self)

func _shoot():
	var laser = bullet.instance()
	laser.position = Vector2(position.x, position.y - 40)
	get_parent().add_child(laser)


func _on_Timer_timeout():
	timer.stop()

func power() :
	powerLabel.max_lines_visible = 0
	for enemy in spawner.enemies:
		score.text = str(int(score.text) + 10)
		get_parent().remove_child(enemy)


func _on_Timer2_timeout():
	power.stop()
	powerLabel.max_lines_visible = 3
	
