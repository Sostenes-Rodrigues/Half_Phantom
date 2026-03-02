event_inherited()


#region State machine
if state_current == states_enemy.idle{
	/// Fist frame
	if state_current_txt != "idle"{
		state_current_txt = "idle"
		
		/// Set sprite
		sprite_index = sprites.idle
		image_index = 0
		image_speed = 1
	}
	
	if image_index > image_number - 1{
		state_current = states_enemy.punch
	}
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
							audio_play_sound(snd_sfx_hit1, 5, false)
							
							if obj_player.life <= 0 {obj_player.state_current = obj_player.states_player.dead};
						}
						else{
							obj_player.life_phantom --
							audio_play_sound(snd_sfx_hit1, 5, false)
							
							if obj_player.life_phantom <= 0 {obj_player.state_current = obj_player.states_player.dead};
						}
					}
					else{
						obj_player.life_gem --
						audio_play_sound(snd_sfx_hit1, 5, false)
							
						if obj_player.life_gem <= 0 {obj_player.state_current = obj_player.states_player.dead};
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
		
		if abs(hspeed) <= .5 {
			state_current = states_enemy.walk
		}
	}
}
else if state_current == states_enemy.dead{
	/// Fist frame
	if state_current_txt != "dead"{
		state_current_txt = "dead"
		
		///
		if form == "ghost"{
			audio_play_sound(snd_sfx_dead_ghost, 5, false, 1, 0, 1.3)
		}
		else if image_index != spr_ball{
			audio_play_sound(snd_sfx_dead_police, 5, false, 1, 0, 1.3)
		}
		
		/// Set sprite
		//sprite_index = sprites.idle
		image_index = 0
	}
	
	instance_destroy(id)
}
else if state_current == states_enemy.ball{
	/// Fist frame
	if state_current_txt != "ball"{
		state_current_txt = "ball"
		
		/// Set sprite
		sprite_index = sprites
		image_index = 0
		
		///
		if xstart < 0{
			hspeed = 2.5
			image_xscale = global.rescale
		}
		else{
			hspeed = -2.5
			image_xscale = -global.rescale
		}
	}
	
	if instance_exists(obj_player){
		if place_meeting(x, y, obj_player){
			if obj_player.state_current == obj_player.states_player.attack_crouch{
				state_current = states_enemy.ball_rebound
			}
			else{
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
					obj_player.life_gem --
					audio_play_sound(snd_sfx_hit1, 5, false)
							
					if obj_player.life_gem <= 0 {obj_player.state_current = obj_player.states_player.dead};
				}
				
				instance_destroy(id)
			}
		}
	}

	if xstart < 0{
		if x > room_width + 64{
			instance_destroy()
		}
	}
	else{
		if x < -64{
			instance_destroy()
		}
	}
}
else if state_current == states_enemy.ball_rebound{
	/// Fist frame
	if state_current_txt != "ball_rebound"{
		state_current_txt = "ball_rebound"
		
		/// Set sprite
		image_index = 0
		
		if xstart < 0{
			hspeed = -2
			image_xscale = -global.rescale
		}
		else{
			hspeed = 2
			image_xscale = global.rescale
		}
	}
	
	if x < -64 or x > room_width + 64{
		instance_destroy(id)
	}
}
#endregion


/*
if keyboard_check_pressed(ord("K")){
	received_knockback(3, 0)
}