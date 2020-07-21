extends Control

signal start
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$LeftPlayerScore.hide()
	$RightPlayerScore.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _set(property, value):
	property = value


func _on_Button_pressed():
	emit_signal("start", $CheckButton.get_value())

func hide_menu():
	$Title.hide()
	$Button.hide()
	$CheckButton.hide()

func show_score():
	$LeftPlayerScore.show()
	$RightPlayerScore.show()
