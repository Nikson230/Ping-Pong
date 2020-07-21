extends Node2D

var score_player_left = 0 setget score_player_left_set
var score_player_right = 0 setget score_player_right_set
# Declare member variables here. Examples:
# var a = 
# var a =
# var b = "text"

var disabled_rackets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	score_player_left = 0
	score_player_right = 0
	menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func score_player_left_set(new_value):
	score_player_left += new_value
	$Control/LeftPlayerScore.text = str(score_player_left)

func score_player_right_set(new_value):
	score_player_right += new_value
	$Control/RightPlayerScore.text = str(score_player_right)

func score_set(side):
	if side == "left":
		score_player_left_set(1)
	else:
		score_player_right_set(1)
func ball_hit(side):
	score_set(side)
	$Ball.hide()
	$Ball/CollisionShape2D.set_deferred("disable", true)
	$Ball.set_disabled(true)
	$Ball.reset($StartPosition.position)
	$StopTimer.start(2)
	$Win.play()

func _on_Ball_left_entering_in_end():
	ball_hit("right")


func _on_Ball_right_entering_in_end():
	ball_hit("left")


func _on_StopTimer_timeout():
	$Ball.set_disabled(false)

func _process(delta):
	for x in disabled_rackets:
		if $Ball.thrust.y > 0 and $Ball.get_disabled():
			x.move_up_set(false)
		elif $Ball.thrust.y < 0 and $Ball.get_disabled():
			x.move_up_set(true)

func _on_LeftRacket_is_disabled(racket, isnt):
	if isnt == true:
		disabled_rackets.append(racket)


func _on_RightRacket_is_disabled(racket, isnt):
	if isnt == true:
		disabled_rackets.append(racket)


func _on_Ball_collision():
	if !$Ball.get_disabled():
		$Hit.play()

func menu():
	$TopBorder.hide()
	$BottomBorder.hide()
	$RightBorder.hide()
	$LeftBorder.hide()
	$LeftRacket.hide()
	$RightRacket.hide()
	$Ball.hide()
	$Ball.set_disabled(true)
	$Control.set_size(OS.get_real_window_size(), false)

func game():
	$TopBorder.show()
	$BottomBorder.show()
	$RightBorder.show()
	$LeftBorder.show()
	$LeftRacket.show()
	$RightRacket.show()
	$Ball.show()
	$StopTimer.start()

func _on_Control_start(value):
	$Control.hide_menu()
	$Control.show_score()
	$RightRacket.set_enable(value)
	game()
