extends KinematicBody2D

export (int) var speed = 200

signal left_entering_in_end
signal right_entering_in_end
signal collision

var thrust = Vector2(1, 1)

var disabled = false setget set_disabled, get_disabled

var rand
var direction_rand = [-1, 1]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_disabled(new_value):
	disabled = new_value

func get_disabled():
	return disabled

func get_position():
	return position

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.set_deferred("disabled", false)
	show()
	direction_rand.shuffle()
	thrust = Vector2(direction_rand[0], direction_rand[0])

func reset(start_position):
	position = start_position
	show()
	$CollisionShape2D.set_deferred("disabled", false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	
func _process(delta):
	if !disabled:
		thrust = thrust.normalized() * speed
		
		var collision = move_and_collide(thrust * delta)
		
		if collision:
			rand = rand_range(-15, 15)
			var reflect = collision.remainder.bounce(collision.normal)
			thrust = thrust.bounce(collision.normal)
			reflect.x += rand
			reflect.y += rand
			move_and_collide(reflect)
			emit_signal("collision")

func _on_RightEnd_body_shape_entered(body_id, body, body_shape, area_shape):
	if !get_disabled():
		emit_signal("right_entering_in_end")


func _on_LeftEnd_body_shape_entered(body_id, body, body_shape, area_shape):
	if !get_disabled():
		emit_signal("left_entering_in_end")
