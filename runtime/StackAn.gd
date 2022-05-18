extends Node2D

class_name StackAn

const DEFAULT_LEVEL := 1
#const SLIDE_FACTOR := 0.015
const SLIDE_FACTOR := 5.0

export var sail_rotation: float = 0.0 setget set_sail_rotation
export var flag_rotation: float = 0.0 setget set_flag_rotation
export var pitch: float = 0.0 setget set_pitch
export var roll: float = 0.0 setget set_roll

var levels := []
var level_origins := []
var level_heights := []


func _ready():
	add_stack_sprite($Sprite, 0.0)
	add_stack_sprite($Sprite2, 1.0)
	add_stack_sprite($Sprite3, 2.0)
	add_stack_sprite($Sprite4, 5.0)
	add_stack_sprite($Sprite5, 8.0)
	add_stack_sprite($AnimatedSprite, 8.0)
	add_stack_sprite($Sprite6, 5.0)
	add_stack_sprite($Sprite8, 4.5)
	add_stack_sprite($Sprite9, 7.5)
	add_stack_sprite($AnimatedSprite2, 7.5)


func add_stack_sprite(sprite: Node2D, height: float):
	levels.append(sprite)
	level_origins.append(sprite.position)
	level_heights.append(height)


func set_pitch(pitch: float):
	
	var tg: float = tan(pitch / 180.0 * PI)
#	pitch * SLIDE_FACTOR
	print(pitch, 1.0 - abs(pitch / 180.0))
	var base_height = level_heights[DEFAULT_LEVEL]
	for i in range(levels.size()):
		var height = level_heights[i]
		levels[i].position.y = level_origins[i].y + tg * SLIDE_FACTOR * (base_height - height)
#		levels[i].scale.y = pow(1.0 - abs(pitch / 180.0)*0.1, 0.5)

func set_roll(roll: float):
	var tg: float = tan(roll / 180.0 * PI)
	var base_height = level_heights[DEFAULT_LEVEL]
	for i in range(levels.size()):
		var height = level_heights[i]
		levels[i].position.x = level_origins[i].x + tg * SLIDE_FACTOR * (base_height - height)
#		levels[i].scale.x = pow(1.0 - abs(pitch / 180.0)*0.1, 0.5)


func set_sail_rotation(rot: float):
	$Sprite4.rotation = rot
	$Sprite5.rotation = rot
	$Sprite6.rotation = rot
	$Sprite8.rotation = rot
	$Sprite9.rotation = rot


func set_flag_rotation(rot: float):
	$AnimatedSprite.rotation = rot
	$AnimatedSprite2.rotation = rot
