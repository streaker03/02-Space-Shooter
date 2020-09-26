extends KinematicBody2D

export (int) var speed = 100

var velocity = Vector2()
onready var score = get_parent().get_child(2)

func _physics_process(delta):
	velocity = move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if "Bullet" in collision.collider.name:
			score.text = str(int(score.text) + 10)
			get_parent().remove_child(collision.collider)
			get_parent().remove_child(self)
			break

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.y += speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
