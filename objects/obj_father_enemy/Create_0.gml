event_inherited()


//
form = "human"

//
sprites = noone

// Store for all enemy states
states_enemy = {
	idle: 0,
	punch: 1,
	walk: 2,
	knockback: 3,
	dead: 4,
	ball: 5,
	ball_rebound: "sss"
}

// Set initial state
state_current = states_enemy.walk

/// TXTs
state_current_txt = ""

///
can_hi1 = true
can_hi2 = false

//
attack = true

//
surf_blur = -1;

/// Methods
received_knockback = function(_force=1, _dir=0){
	/// Set the moviment
	var _sign = 1/////////////////////////////////////
	if x < room_width / 2 {_sign = -1}
	hspeed = lengthdir_x(_force, abs(_dir)) * _sign
	if _dir == 0{
		hspeed = lengthdir_x(_force, abs(_dir))
	}
	else if _dir == 180{
		hspeed = -7.8
	}
	
	vspd = lengthdir_y(_force, abs(_dir))
	
	
	// Go to state knockback
	if sprite_index != spr_ball{
		state_current = states_enemy.knockback
	}
}
