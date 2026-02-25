event_inherited()


#region Capture directional inputs and store in buffer

// If left was pressed
if (keyboard_check_pressed(vk_left))
{
    buffer_input = vk_left;
    buffer_timer = BUFFER_TIME;
}

// If right was pressed
if (keyboard_check_pressed(vk_right))
{
    buffer_input = vk_right;
    buffer_timer = BUFFER_TIME;
}

// If up was pressed
if (keyboard_check_pressed(vk_up))
{
    buffer_input = vk_up;
    buffer_timer = BUFFER_TIME;
}

// If down was pressed
if (keyboard_check_pressed(vk_down))
{
    buffer_input = vk_down;
    buffer_timer = BUFFER_TIME;
}

// Decrease buffer timer every frame
if (buffer_timer > 0)
{
    buffer_timer -= 1;
}

// Clear buffer when time expires
if (buffer_timer <= 0)
{
    buffer_input = -1;
}
#endregion


/// Control, if I on ground, I can use attack fall all
if on_ground{
	can_attack_fall_all = true
}

// Reduce combo timer
if (combo_timer > 0)
{
    combo_timer -= 1;
}

#region State machine
if state_current == states_player.idle{
	/// Fist frame
	if state_current_txt != "idle"{
		state_current_txt = "idle"
		
		// Set idle sprite
		sprite_index = sprites.idle
		image_index = 0
	}
	
    
	// If there is buffered input
	if (buffer_input != -1){
	    /// Punch normal
		// If right input buffered
	    if (buffer_input == vk_right)
	    {
	        image_xscale = global.rescale
			
			state_current = states_player.punch
	    }
        
	    // If left input buffered
	    if (buffer_input == vk_left)
	    {
	        image_xscale = -global.rescale
			
	        state_current = states_player.punch
	    }
		
        
	    // If down input buffered
	    if (buffer_input == vk_down)
	    {
			state_current = states_player.crouch
	    }
        
	    // If up input buffered
	    trigger_jump()
        
	    // Clear buffer after consuming
	    buffer_input = -1
	    buffer_timer = 0
	}
}
    
    
else if state_current == states_player.punch
{
	/// Enter state
	if state_current_txt != "punch"{
		state_current_txt = "punch"
		
		sprite_index = sprites.punch
		image_index = 0
		
		/// Activate hitbox
		hitbox_attack.active = true
    
		hitbox_attack.y1 = y - 30
		hitbox_attack.y2 = y - 25
	}
	
	
	if keyboard_check_pressed(vk_right) {image_xscale = global.rescale}
	if keyboard_check_pressed(vk_left) {image_xscale = -global.rescale}
	hitbox_attack.x1 = x + (4 * sign(image_xscale)) - 1
	hitbox_attack.x2 = x + (19 * sign(image_xscale)) - 1
	
	/// When animation finishes
	if (image_index >= image_number - 1){
		/// Check continuous intention to punch
		var want_punch =
			buffer_input == vk_left or
			buffer_input == vk_right or
			keyboard_check_pressed(vk_left) or
			keyboard_check_pressed(vk_right);
		
		/// If player still wants to punch
		if (want_punch)
		{
			/// Change direction if needed
			if (keyboard_check(vk_right) or buffer_input == vk_right)
				image_xscale = global.rescale;
				
			if (keyboard_check(vk_left) or buffer_input == vk_left)
				image_xscale = -global.rescale;
			
			/// Reset animation for smooth loop
			image_index = 0;
			
			/// Clear buffer
			buffer_input = -1;
			buffer_timer = 0;
		}
		else
		{
			/// Stop attacking
			hitbox_attack.active = false;
			state_current = states_player.idle;
		}
	}
	
	// If up input buffered
	trigger_jump()
}


else if state_current == states_player.fire{
	/// Fist frame
	if state_current_txt != "fire"{
		state_current_txt = "fire"
		
		sprite_index = sprites.fire
		image_index = 0
	}
}

    
else if state_current == states_player.crouch{
	/// Fist frame
	if state_current_txt != "crouch"{
		state_current_txt = "crouch"
		
		sprite_index = sprites.crouch
		image_index = 0
	}
    
    
	// If there is buffered input
	if (buffer_input != -1){
		if (buffer_input == vk_down)
		{
			state_current = states_player.attack_crouch
		}
    
		if (buffer_input == vk_right or buffer_input == vk_left)
		{
			// Force jump
			vspd = force_jump * .6
	        
			state_current = states_player.jump
			
			///
			image_xscale = ((buffer_input == vk_right) ? global.rescale : -global.rescale);
		}
		
		// If up input buffered
	    trigger_jump()
		
		
		/// Reset buffer
		buffer_input = -1
		buffer_timer = 0
	}
}


else if state_current == states_player.attack_crouch{
	/// Fist frame
	if state_current_txt != "attack_crouch"{
		state_current_txt = "attack_crouch"
		
		// Alternate low attack sprite
	    sprite_index = sprites.attack_crouch
		image_index = 0
        
		
	    // Activate hitbox
	    hitbox_attack.active = true
        
	    // Define low hitbox
	    hitbox_attack.x1 = x + (5 * sign(image_xscale)) - 1
	    hitbox_attack.y1 = y - 18
		hitbox_attack.x2 = x + (20 * sign(image_xscale)) - 1
		hitbox_attack.y2 = y
	}
    
        
    // Stay crouched after attack
    if (image_index >= image_number - 1){
        hitbox_attack.active = false
		
		state_current = states_player.crouch
    }
}
    
    
else if state_current == states_player.fire_crouch{
	/// Fist frame
	if state_current_txt != "fire_crouch"{
		state_current_txt = "fire_crouch"
		
		sprite_index = sprites.fire_crouch
		image_index = 0
	}
}
    
    
else if state_current == states_player.jump{
	/// Fist frame
	if state_current_txt != "jump"{
		state_current_txt = "jump"
		
		// Set jump sprite
		sprite_index = sprites.jump
		image_index = 0
		
		on_ground = false
		
		
		/// Config hitbox
		hitbox_attack.active = true
    
		hitbox_attack.x1 = x + (4 * sign(image_xscale))
		hitbox_attack.x2 = x + (19 * sign(image_xscale))
		hitbox_attack.y2 = y + 45
		
		modi_y2 = 45
	}
    
	
	modi_y2 = lerp(modi_y2, -20, .1)
	//hitbox.y2 = clamp(hitbox.y2, -20, 45)
	
	/// Config hitbox
	hitbox_attack.y1 = y - 40
	hitbox_attack.y2 = y + modi_y2
	
    /// When going down switch to fall
    if vspd > 0{
		hitbox_attack.active = false
		
		state_current = states_player.fall
    }
    
    // Air attack input
    trigger_attack_fall_all()
}


else if state_current == states_player.fall{
	/// Fist frame
	if state_current_txt != "fall"{
		state_current_txt = "fall"
		
		// Set fall sprite
		sprite_index = sprites.fall
		image_index = 0
	}
	
        
    // If land return idle
    if on_ground{
		state_current = states_player.idle
    }
	
	
	// If there is buffered input
	if (buffer_input != -1)
	{
	    /// Punch Fall
		// If right input buffered
	    if (buffer_input == vk_right)
	    {
	        image_xscale = global.rescale
			
			state_current = states_player.attack_fall
	    }
        
	    // If left input buffered
	    if (buffer_input == vk_left)
	    {
	        image_xscale = -global.rescale
			
	        state_current = states_player.attack_fall
	    }
		
        
	    // Clear buffer after consuming
	    buffer_input = -1;
	    buffer_timer = 0;
	}
	
	// Air attack input
    trigger_attack_fall_all()
}
    

else if state_current == states_player.attack_fall{
	/// Fist frame
	if state_current_txt != "attack_fall"{
		state_current_txt = "attack_fall"
		
		sprite_index = sprites.attack_fall
		image_index = 0
		
		/// Activate hitbox
		hitbox_attack.active = true
		hitbox_attack.x1 = x + (4 * sign(image_xscale)) - 1
		hitbox_attack.x2 = x + (19 * sign(image_xscale)) - 1
	}
	
	
	/// Position hitbox
	hitbox_attack.y1 = y - 30
	hitbox_attack.y2 = y - 25
	
	/// When animation finishes
	if (image_index >= image_number - 1){
		/// Just falling
		hitbox_attack.active = false
		state_current = states_player.fall
	}
	
	if on_ground{
		/// Stop attacking
		hitbox_attack.active = false;
		state_current = states_player.idle
	}
}


else if state_current == states_player.attack_fall_all{
	/// Fist frame
	if state_current_txt != "attack_fall_all"{
		state_current_txt = "attack_fall_all"
		
		// Set spin sprite
	    sprite_index = sprites.attack_fall_all
		image_index = 0
        
		
	    // Activate hitbox
	    hitbox_attack.active = true
        
	    // Spin hitbox covers both sides
	    hitbox_attack.x1 = x - 20
	    hitbox_attack.x2 = x + 20
	    
		hitbox_attack.x1 -= image_xscale < 0 ? 3 : 0;
		hitbox_attack.x2 += image_xscale > 0 ? 3 : 0;
	}
    
	
	/// Position hitbox
	hitbox_attack.y1 = y - 20
	hitbox_attack.y2 = y - 10
	
    if (image_index >= image_number - 1)
    {
        hitbox_attack.active = false;
		
		state_current = states_player.fall
    }
}
    
    
else if state_current == states_player.fire_fall{
	/// Fist frame
	if state_current_txt != "fire_fall"{
		state_current_txt = "fire_fall"
		
		sprite_index = sprites.fire_fall
		image_index = 0
	}
}
#endregion
