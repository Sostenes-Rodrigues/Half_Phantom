types = ["human", "ghost"]


// Store for all enemy sprites
enemy_sprites = {
	human: {
		idle: spr_police_idle,
		punch: spr_police_attack,
		walk: spr_police_run
	},
	ghost: {
		idle: spr_police_idle,
		punch: spr_police_attack,
		walk: spr_police_run
	}
}


/// Methods
// Spawne enemy
spawnw_enemy = function(_side="left", _type="human"){
	var _x = 0
	var _y = 0
	if _side == "left"{
		_x = -20
	}
	else{
		_x = room_width + 20
	}
	
	var _inst = instance_create_layer(_x, room_height - 2, "Instances", obj_father_enemy)
	_inst.form = _type
	if _type == "human"{
		_inst.sprites = enemy_sprites.human
	}
	else{
		_inst.sprites = enemy_sprites.ghost
	}
}
