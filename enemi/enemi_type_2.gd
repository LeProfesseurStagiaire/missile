extends Node2D

var motion = Vector2(0,0)
var rotation_speed = rand_range(2,5)
var speed = rand_range(2,4)
var scale_ratio = rand_range(0.3,0.7)
var time_left = rand_range(3,6)
var next_spawn_time = (rand_range(1,1.5))
onready var radar = load("res://enemi/radar_enemi.tscn").instance()
onready var d_mark = load("res://enemi/death_mark_enemi.tscn").instance()

func _ready():
	modulate = Color(1,1,1,time_left * 0.1)
	radar.position = Vector2(get_viewport_rect().size.x / 2,get_viewport_rect().size.x / 2)
	get_tree().get_current_scene().add_child(radar)
	radar.look_at(position)
	look_at(get_global_mouse_position())
	scale = Vector2(scale_ratio,scale_ratio)
	if global.wave.get("wave_"+str(global.wave_selected)).get("param").has("scale"):
		radar.scale = global.wave.get("wave_"+str(global.wave_selected)).get("param").get("scale")

func _process(delta):
	self.rotate(get_angle_to(get_global_mouse_position())*delta * rotation_speed )
	var movedir = Vector2(speed,0).rotated(rotation)
	motion = motion.linear_interpolate(movedir,1)
	position += motion * 100 * delta

func _on_Timer_timeout():
	if time_left > 2:
		time_left -=1
		$Timer.start(1)
	else :
		die()
	modulate = Color(1,1,1,time_left * 0.1)

func die():
	d_mark.position = position
	get_tree().get_current_scene().add_child(d_mark)
	queue_free()
	
func _on_Area2D_area_entered(area):
	if area.is_in_group("wave_exp"):
		die()
