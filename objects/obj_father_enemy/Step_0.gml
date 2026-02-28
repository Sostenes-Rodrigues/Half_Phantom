event_inherited()


#region State machine
if state_current == states_enemy.idle{
	/// Fist frame
	if state_current_txt != "idle"{
		state_current_txt = "idle"
		
		/// Set sprite
		sprite_index = sprites.idle
		image_index = 0
	}
	
	state_current = states_enemy.punch
}
else if state_current == states_enemy.punch{
	/// Fist frame
	if state_current_txt != "punch"{
		state_current_txt = "punch"
		
		/// Set sprite
		sprite_index = sprites.punch
		image_index = 0
		
		//
		attack = true
	}
	
	if image_index == 2{
		if attack{
			if instance_exists(obj_player){
				if place_meeting(x, y, obj_player){
					attack = false
					
					if global.form == form{
						if form == "human"{
							obj_player.life --
							
							if obj_player.life <= 0 {obj_player.state_current = obj_player.states_player.dead};
						}
						else{
							obj_player.life_phantom --
							
							if obj_player.life_phantom <= 0 {obj_player.state_current = obj_player.states_player.dead};
						}
					}
					else{
						obj_player.state_current = obj_player.states_player.dead
					}
				}
			}
		}
	}

	
	if image_index > image_number - 1{
		state_current = states_enemy.idle
	}
}
else if state_current == states_enemy.walk{
	/// Fist frame
	if state_current_txt != "walk"{
		state_current_txt = "walk"
		
		// Set sprite
		sprite_index = sprites.walk
		image_index = 0
		
		/// Run middle
		speed = 1
		direction = point_direction(x, y, room_width / 2, y)
	}
	
	/// Stop in front of the player
	if distance_to_point(room_width / 2, y) <= 12{
		speed = 0
		
		// Go Idle state
		state_current = states_enemy.idle
	}
}
else if state_current == states_enemy.knockback{
	/// Fist frame
	if state_current_txt != "knockback"{
		state_current_txt = "knockback"
		
		/// Set sprite
		//sprite_index = sprites.idle
		image_index = 0
	}
	
	
	///
	hspeed -= .2 * sign(hspeed)
	
	//
	if on_ground{
		hspeed = lerp(hspeed, 0, .13)
		
		if hspeed <= .5 {
			state_current = states_enemy.walk
		}
	}
}
else if state_current == states_enemy.dead{
	/// Fist frame
	if state_current_txt != "dead"{
		state_current_txt = "dead"
		
		/// Set sprite
		//sprite_index = sprites.idle
		image_index = 0
	}
	
	instance_destroy(id)
}
#endregion


/*
if keyboard_check_pressed(ord("K")){
	received_knockback(3, 0)
}