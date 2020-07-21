extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed = 200
export (bool) var enable = true setget set_enable, is_enabled
var velocity = Vector2()

var move_up setget move_up_set, move_up_get

signal is_disabled
# Called when the node enters the scene tree for the first time.

func move_up_set(new_value):
	move_up = new_value

func move_up_get():
	return move_up

func _ready():
	if !is_enabled():
		emit_signal("is_disabled", self, true)
	else:
		emit_signal("is_disabled", self, false)

func get_input():
	velocity = Vector2()
	if is_enabled():
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1	
	else:
		speed = 100
		if move_up_get() == true:
			velocity.y -= 1
		else:
			velocity.y += 1
	velocity = velocity.normalized() * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))

func set_enable(new_value):
	enable = new_value

func is_enabled():
	return enable
