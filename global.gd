extends Node

var best_score = 0
onready var wave_unlocked = 1
var wave_selected = 1
onready var max_wave = wave.size()
var caract_list = ["speed","scale_ratio","rotation_speed","next_spawn_time"]

#used to select the last level selected if you die without unlock new wave
var wave_unlocked_this_turn = false

var wave = {

"wave_1" : {
	"Etype" : [1], 
	"Ecarac" : {
		1:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
	},
	"param" : {
		"goal_time" : int(10),"color" : Color(0.047059, 0.321569, 0.329412),"scale" : Vector2(0.9,0.9)
	}
},

"wave_2" : {
	"Etype" : [2], 
	"Ecarac" : {
		2:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
	},
	"param" : {
		"goal_time" : int(10),"color" : Color(0.157059, 0.321569, 0.329412),"scale" : Vector2(0.85,0.85)
	}
},

"wave_3" : {
	"Etype" : [3], 
	"Ecarac" : {
		3:{"next_spawn_time" : Vector2(1,1)},
	},
	"param" : {
		"goal_time" : int(10),"color" : Color(0.267059, 0.321569, 0.329412),"scale" : Vector2(0.8,0.8)
	}
},

"wave_4" : {
	"Etype" : [4], 
	"Ecarac" : {
		4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
	},
	"param" : {
		"goal_time" : int(10),"color" : Color(0.377059, 0.321569, 0.329412),"scale" : Vector2(0.75,0.75)
	}
},

"wave_5" : {
	"Etype" : [1,4], 
	"Ecarac" : {
		1:{"speed": Vector2(2,3),"next_spawn_time" : Vector2(0.3,0.6)},
	},
	"param" : {
		"goal_time" : int(10),"color" : Color(0.477059, 0.321569, 0.329412),"scale" : Vector2(0.7,0.7)
	}
},
"wave_6" : {
	"Etype" : [1,2], 
	"Ecarac" : {
		2:{"speed": Vector2(1,3),"scale_ratio":Vector2(0.5,1.3)},
	},
	"param" : {
		"goal_time" : int(10),"color" : Color(0.577059, 0.321569, 0.329412),"scale" : Vector2(0.65,0.65)
	}
},
"wave_7" : {
	"Etype" : [3], 
	"Ecarac" : {
		3:{"speed": Vector2(4,6),"next_spawn_time" : Vector2(0.3,0.5)},
	},
	"param" : {
		"goal_time" : int(10),"color" : Color(0.677059, 0.321569, 0.329412),"scale" : Vector2(0.6,0.6)
	}
},
"wave_8" : {
	"Etype" : [3,4], 
	"Ecarac" : {
		3:{"speed": Vector2(4,5)},
		4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(0.4,0.7),"scale_ratio" : Vector2(0.2,0.35)},
	},
	"param" : {
		"goal_time" : int(10),"color" : Color(0.777059, 0.321569, 0.329412),"scale" : Vector2(0.55,0.55)
	}
},
"wave_9" : {
	"Etype" : [1,3,4], 
	"Ecarac" : {
		4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(1,2)},
	},
	"param" : {
		"goal_time" : int(10),"color" : Color(0.87059, 0.321569, 0.329412),"scale" : Vector2(0.5,0.5)
	}
},
"wave_10" : {
	"Etype" : [1,2,3,4], 
	"Ecarac" : {
		4:{"speed": Vector2(1,3),"next_spawn_time" : Vector2(0.1,0.2)},
		3:{"speed": Vector2(3,5),"next_spawn_time" : Vector2(0.1,0.2)}
	},
	"param" : {
		"goal_time" : int(10),"color" : Color(0.977059, 0.321569, 0.329412),"scale" : Vector2(0.45,0.45)
	}
},

"wave_11" : {
	"Etype" : [1,3,4], 
	"Ecarac" : {
		4:{"speed": Vector2(2,2.5),"next_spawn_time" : Vector2(0.1,0.2),"rotation_speed":Vector2(0.5,1)},
		3:{"speed": Vector2(5,8),"next_spawn_time" : Vector2(0.1,0.2)},
		1:{"next_spawn_time" : Vector2(0.6,1.2),"scale_ratio":Vector2(0.1,0.2)}
	},
	"param" : {
		"goal_time" : int(30),"color" : Color(0.335938, 0, 0)
	}
},

}