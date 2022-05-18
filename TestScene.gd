extends Node2D

onready var yacht: StackAn = $StackAn


func _input(event):
	var center: Vector2 = get_viewport().size / 2.0
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			yacht.sail_rotation = center.angle_to(event.position)
			yacht.flag_rotation = center.angle_to(event.position) - PI
#		else:
#			yacht.pitch = event.position.x - center.x
#			yacht.roll = event.position.y - center.y
#

