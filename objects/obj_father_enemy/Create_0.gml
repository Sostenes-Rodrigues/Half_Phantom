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
