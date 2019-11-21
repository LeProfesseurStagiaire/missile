extends Node2D

var enemi
onready var wave_selected
onready var death_marker = preload("res://player/death_mark.tscn")
onready var wave_exp = preload("res://player/wave_explosion.tscn").instance()
var spawn_timer = 1
var game_runing = false
var game_endend = false

signal game_run
signal game_stop

func _input(event):
	if game_runing == false && game_endend == false:
		if Input.is_action_just_pressed("scroll_down"):
			if wave_selected > 1 :
				wave_selected -= 1
		if Input.is_action_just_pressed("scroll_up"):
			if wave_selected < global.wave_unlocked:
				wave_selected += 1
		draw_menu()
	if Input.is_action_just_pressed("play"):
		if game_runing == false && game_endend == false:
			global.wave_selected = wave_selected
			game_runing = true
			$start_txt/start_message_sprite.hide()
			$start_txt/wave_selected_text.hide()
			emit_signal("game_run")
		if game_runing == false && game_endend == true:
			get_tree().reload_current_scene()

func draw_menu():
	$start_txt/wave_selected_text.text = "WAVE : "+str(wave_selected)
	if global.wave.get("wave_"+str(wave_selected)).get("param").has("color"):
		$color/ColorRect.color = global.wave.get("wave_"+str(wave_selected)).get("param").get("color")
	else :
		$color/ColorRect.color = Color(0.192157, 0.192157, 0.192157)
	if global.wave.get("wave_"+str(wave_selected)).get("param").has("scale"):
		$Sprite.scale = global.wave.get("wave_"+str(wave_selected)).get("param").get("scale")
	else :
		$Sprite.scale = Vector2(1,1)

func game_stop():
	emit_signal("game_stop")
	game_ended()
	wave_exp.position = Vector2(get_viewport_rect().size.x /2 ,get_viewport_rect().size.x/2)
	add_child(wave_exp)


func player_death(p):
	emit_signal("game_stop")
	game_ended()
	var m = death_marker.instance()
	m.position = p
	add_child(m)

func game_ended():
	$start_txt/start_message_sprite.show()
	$Timer.stop()
	game_runing = false
	game_endend = true

func _ready():
	if global.wave_unlocked_this_turn:
		wave_selected = global.wave_unlocked
	else:
		wave_selected = global.wave_selected
	global.wave_unlocked_this_turn = false
	draw_menu()
	$Timer.start(1)
	$start_txt/wave_selected_text.text = "WAVE : "+str(wave_selected)

func _on_Timer_timeout():
	if game_runing == true :
		var rand_enemi_type = global.wave.get("wave_"+str(wave_selected)).get("Etype")[rand_range(0,global.wave.get("wave_"+str(wave_selected)).get("Etype").size())]
		randomize()
		var spawn_position = int(rand_range(0,3))
		var rand_pos = get_viewport_rect().size.x - rand_range(0,get_viewport_rect().size.x)
		var pos = Vector2()
		if spawn_position == 0 :
			pos = Vector2(rand_pos, 0)
		if spawn_position == 1 :
			pos = Vector2(0, rand_pos)
		if spawn_position == 2 :
			pos = Vector2(get_viewport_rect().size.x, rand_pos)
		if spawn_position == 3 :
			pos = Vector2(rand_pos, get_viewport_rect().size.x)
		enemi = load("res://enemi/enemi_type_" +str(rand_enemi_type)+".tscn") 
		var spawn = enemi.instance()
		if global.wave.get("wave_"+str(wave_selected)).get("Ecarac").has(rand_enemi_type):
			for x in global.caract_list:
				if global.wave.get("wave_"+str(wave_selected)).get("Ecarac").get(rand_enemi_type).has(x):
					spawn.set(x,rand_range(global.wave.get("wave_"+str(wave_selected)).get("Ecarac").get(rand_enemi_type).get(x).x,
					global.wave.get("wave_"+str(wave_selected)).get("Ecarac").get(rand_enemi_type).get(x).y))
		spawn.position = pos
		add_child(spawn)
		$Timer.start(spawn.next_spawn_time)