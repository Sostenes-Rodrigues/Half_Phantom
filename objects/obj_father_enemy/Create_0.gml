event_inherited()


// Store for all enemy states
states_enemy = {
	idle: 0,
	punch: 1,
	walk: 2,
	knockback: 3,
	dead: 4
}

// Set initial state
state_current = states_enemy.walk

/// TXTs
state_current_txt = ""

///
can_hi1 = true
can_hi2 = false

/// Methods
received_knockback = function(_force=1, _dir=0){
	/// Set the moviment
	hspeed = lengthdir_x(_force, abs(_dir)) * sign(_dir)
	if _dir == 0{
		hspeed = lengthdir_x(_force, abs(_dir))
	}
	
	vspd = lengthdir_y(_force, abs(_dir))
	
	
	// Go to state knockback
	state_current = states_enemy.knockback
}
