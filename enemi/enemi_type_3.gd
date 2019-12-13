extends Node2D

var motion = Vector2(0,0)
var rotation_speed
var speed = rand_range(7,15)
var scale_ratio = rand_range(0.3,0.7)
var next_spawn_time = (rand_range(1,1.5))
onready var radar = load("res://enemi/radar_enemi.tscn").instance()
onready var d_mark = load("res://enemi/death_mark_enemi.tscn").instance()

func _ready():
	$Area2D/CollisionShape2D.shape.set_extents((($Sprite.get_rect().size) * $Sprite.scale) /2)
	set_process(false)
	radar.position = Vector2(get_viewport_rect().size.x / 2,get_viewport_rect().size.x / 2)
	get_tree().get_current_scene().add_child(radar)
	radar.look_at(position)
	look_at(get_global_mouse_position())
	scale = Vector2(scale_ratio + 0.1,scale_ratio)
	if global.wave.get("wave_"+str(global.wave_selected)).get("param").has("scale"):
		radar.scale = global.wave.get("wave_"+str(global.wave_selected)).get("param").get("scale")

func _process(delta):
	var movedir = Vector2(speed,0).rotated(rotation)
	motion = motion.linear_interpolate(movedir,1)
	position += motion * 100 * delta

func _on_Timer_timeout():
	set_process(true)

func _on_VisibilityNotifier2D_screen_exited():
	#disconnect or error !
#	$VisibilityNotifier2D.disconnect("screen_exited",self,"_on_VisibilityNotifier2D_screen_exited")
	die()
	
func die():
	d_mark.position = position
	get_tree().get_current_scene().call_deferred("add_child",d_mark)
	queue_free()

func _on_Area2D_area_entered(area):
	if area.is_in_group("wave_exp"):
		die()