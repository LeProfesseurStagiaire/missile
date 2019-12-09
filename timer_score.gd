extends Node2D

var time = 0
var can_count = false
var new_hight_score = false
var goal_time

var dead_sentence = ["wtf, you died !", "haha, you died", "want to beat me ?","try agan !!","you can't do it...","want to see the end ?","LOL !!"]

func _ready():
	set_process(false)
#	$hight_score.text = str("best :" + str(global.best_score))
	$score.text = str(0)
	$score.hide()
	$goal_score.hide()
	get_tree().get_current_scene().connect("game_run",self,"start")
	get_tree().get_current_scene().connect("game_stop",self,"stop")
	$AnimationPlayer.play("timer")

#func _process(delta):
#	if new_hight_score == false && time >= global.best_score:
#		new_hight_score = true

func _on_time_timeout():
	if can_count == true:
		time += 1
		$score.text = str(time)
		if time >= goal_time:
			#the wave is ended
			get_tree().get_current_scene().game_stop()
			if global.wave_unlocked < global.max_wave && global.wave_selected == global.wave_unlocked:
				global.wave_unlocked += 1
				global.wave_unlocked_this_turn = true
		else: 
			$time.start(1)

func start():
	$score.show()
	$goal_score.show()
	goal_time = global.wave.get("wave_"+str(global.wave_selected)).get("param").get("goal_time")
	$goal_score.text = str("GOAL :" + str(goal_time))
	set_process(true)
	$time.start(1)
	can_count = true

func stop():
	if ! global.wave_unlocked_this_turn:
		global.wave_unlocked_this_turn = false
	can_count = false
	$dead.text = dead_sentence[int(rand_range(0,dead_sentence.size()))]