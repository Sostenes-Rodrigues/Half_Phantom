event_inherited()


#region State machine
if state_current == states_enemy.idle{
	
}
else if state_current == states_enemy.punch{
	
}
else if state_current == states_enemy.walk{
	/// Fist frame
	if state_current_txt != "walk"{
		state_current_txt = "walk"
		
		// Set sprite
		//sprite_index = sprites.idle
		image_index = 0
		
		/// Run middle
		speed = 1
		direction = point_direction(x, y, room_width / 2, y)
	}
	
	/// Stop in front of the player
	if distance_to_point(room_width / 2, y) <= 12{
		speed = 0
	}
}
else if state_current == states_enemy.knockback{
	
}
else if state_current == states_enemy.dead{
	
}
#endregion
