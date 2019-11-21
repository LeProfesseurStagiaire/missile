extends Node2D

var motion = Vector2(0,0)
var rotation_speed = rand_range(2,5)
var speed = rand_range(2,4)
var s = rand_range(0.3,0.7)
onready var radar = load("res://radar_enemi.tscn").instance()

func _ready():
	radar.position = Vector2(get_viewport_rect().size.x / 2,get_viewport_rect().size.x / 2)
	get_tree().get_current_scene().add_child(radar)
	radar.look_at(position)
	look_at(get_global_mouse_position())
	scale = Vector2(s,s)

func _process(delta):
	self.rotate(get_angle_to(get_global_mouse_position())*delta * rotation_speed )
	var movedir = Vector2(speed,0).rotated(rotation)
	motion = motion.linear_interpolate(movedir,1)
	position += motion * 100 * delta

func _on_Area2D_area_entered(area):
	if area.is_in_group("enemi"):
		self.queue_free()
