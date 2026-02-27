event_inherited()


/// Create a struct containing all player sprites
sprites = {
    
    // Idle sprite
    idle: spr_player_idle,
    
    // Punch sprites
    punch: spr_player_attack,
	
	// Gun Fire sprites
	fire: spr_player_fire,
    
    // Crouch sprite
    crouch: spr_player_down,
    
    // Low attack variations
    attack_crouch: spr_player_attack_down,
	
    // Low gun fire variations
    fire_crouch: spr_player_fire_down,
    
    // Jump sprite
    jump: spr_player_shoryuken,
    
    // Falling sprite
    fall: spr_player_falling,
    
    // Air attacks
    attack_fall: spr_player_attack_falling,
    attack_fall_all: spr_player_attack_falling_all,
	
	// Air gun fire sprites
	fire_fall: spr_player_fire_falling
};
sprites_ghost = {
    
    // Idle sprite
    idle: spr_player_idle,
    
    // Punch sprites
    punch: spr_player_attack,
	
	// Gun Fire sprites
	fire: spr_player_fire,
    
    // Crouch sprite
    crouch: spr_player_down,
    
    // Low attack variations
    attack_crouch: spr_player_attack_down,
	
    // Low gun fire variations
    fire_crouch: spr_player_fire_down,
    
    // Jump sprite
    jump: spr_player_shoryuken,
    
    // Falling sprite
    fall: spr_player_falling,
    
    // Air attacks
    attack_fall: spr_player_attack_falling,
    attack_fall_all: spr_player_attack_falling_all,
	
	// Air gun fire sprites
	fire_fall: spr_player_fire_falling
};


// Store for all player states
states_player = {
	idle: 0,
	punch: 1,
	fire: 2,
	crouch: 3,
	attack_crouch: 4,
	fire_crouch: 5,
	jump: 6,
	fall: 7,
	attack_fall:8,
	attack_fall_all: 9,
	fire_fall: 10
}

// Set initial state
state_current = states_player.fall

/// TXTs
state_current_txt = ""


// Combo timer
combo_timer = 0;

// Force jump
force_jump = -10


// Variable control if can attack_fall_all
can_attack_fall_all = true

// Hitbox struct
hitbox_attack = {
    active: false,
    x1: 0,
    y1: 0,
    x2: 0,
    y2: 0
};

///

//
modi_y2 = 0

// Store buffered input key
buffer_input = -1;

// Store buffer timer
buffer_timer = 0;

// How many frames the input stays buffered
BUFFER_TIME = 11;


#region Methods
/// Jump
trigger_jump = function(){
	// If up input buffered
	if (buffer_input == vk_up)
	{
	    // Force jump
		vspd = force_jump
	        
		state_current = states_player.jump
	}
}

/// Air Attack fall all
trigger_attack_fall_all = function(){
    if keyboard_check_pressed(vk_up) and can_attack_fall_all{
		can_attack_fall_all = false
		
        if vspd > 0 {
			vspd = force_jump * .4
		}
		else if vspd < 0 {
			vspd += force_jump * .2
		}
		
		state_current = states_player.attack_fall_all
	}
}

/// Set damage
set_damage = function(_type=1, _damage=1, _knockback=false, _force=0, _dir=0){
	var _array_inst = ds_list_create()
	var _array_inst_cont = collision_rectangle_list(hitbox_attack.x1, hitbox_attack.y1, hitbox_attack.x2, hitbox_attack.y2, obj_father_enemy, false, true, _array_inst, true)
	
	var _inst = noone
	if _array_inst_cont > 0{
		///
		if _type == 3{
			for (var i = 0; i < ds_list_size(_array_inst); ++i){
			    //
				_inst = _array_inst[| i]
				
				if _inst.state_current_txt != "knockback"{
					_inst.life -= _damage
				}
			}
		}
		else{
			/// Get nearest instance
			_inst = _array_inst[| 0]
		
			if _inst.state_current_txt != "knockback"{
				if _type == 1 and _inst.can_hi1{
					_inst.life -= _damage
					_inst.can_hi1 = false
					_inst.can_hi2 = true
				}
				if _type == 2 and _inst.can_hi2{
					_inst.life -= _damage
					_inst.can_hi1 = true
					_inst.can_hi2 = false
				}			
			}
		}
		
		///
		if _knockback{
			_inst.received_knockback(_force, _dir)
		}
			
		if _inst.life <= 0{
			_inst.state_current = _inst.states_enemy.dead
		}
	}
	
	ds_list_clear(_array_inst)
	ds_list_destroy(_array_inst)
	
	return _inst
}

/// Create Bullet
create_bullet = function(){
	
}
#endregion
