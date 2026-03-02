/// Start music, if not running
if !audio_is_playing(snd_music_game)
{
    audio_play_sound(snd_music_game, 0, true, 1, 1, 1.26)
}


types = ["human", "ghost", "ball"]


// Store for all enemy sprites
enemy_sprites = {
	human: {
		idle: spr_police_idle,
		punch: spr_police_attack,
		walk: spr_police_run
	},
	ghost: {
		idle: spr_ghost,
		punch: spr_ghost_attack,
		walk: spr_ghost
	},
	ball: spr_ball
}


/// Methods
// Spawne enemy
spawnw_enemy = function(_side="left", _type="human"){
	var _xs = global.rescale
	var _x = 0
	var _y = 0
	if _side == "left"{
		_x = -20
	}
	else{
		_x = room_width + 20
		_xs = -global.rescale
	}
	
	var _inst = instance_create_layer(_x, room_height - 2, "Instances", obj_father_enemy)
	_inst.form = _type
	_inst.image_xscale = _xs
	if _type == "human"{
		_inst.sprites = enemy_sprites.human
	}
	else if _type == "ghost"{
		_inst.sprites = enemy_sprites.ghost
	}
	else{
		_inst.sprites = enemy_sprites.ball
		_inst.state_current = _inst.states_enemy.ball
	}
	
	
	if _type == "ball" {
		_inst.form = "human"
	}
}


//
global.defeat = false


//
btn_hover = false;



/// Spawner
global.timer = 180

spawn_timer = 0;
spawn_interval = 2.6; // era 2.0 → 30% mais lento

last_side = "";
same_side_count = 0;

total_time = global.timer

function control_spawner()
{
    /// =========================
    /// TIMER GLOBAL
    /// =========================
    
    if (global.timer > 0)
    {
        global.timer -= delta_time / 1000000;
    }
    
    
    /// =========================
    /// QUANDO O TEMPO ACABA
    /// =========================
    
    if (global.timer <= 0)
    {
        global.timer = 0;
        
        // >>> FINAL DO JOGO AQUI <<<
        
        return;
    }
    
    
    /// =========================
    /// PROGRESSO
    /// =========================
    
    var progress = 1 - (global.timer / total_time);
    
    
    /// =========================
    /// DIFICULDADE (30% MAIS LEVE)
    /// =========================
    
    spawn_interval = lerp(2.6, 0.7, progress);
    
    
    /// =========================
    /// CONTROLE DE SPAWN
    /// =========================
    
    spawn_timer += delta_time / 1000000;
    
    if (spawn_timer >= spawn_interval)
    {
        spawn_timer = 0;
        
        
        /// =========================
        /// ESCOLHER LADO (ANTI 4 SEGUIDOS)
        /// =========================
        
        var side;
        
        if (same_side_count >= 3)
        {
            side = (last_side == "left") ? "right" : "left";
            same_side_count = 0;
        }
        else
        {
            side = choose("left", "right");
        }
        
        if (side == last_side)
            same_side_count++;
        else
            same_side_count = 1;
        
        last_side = side;
        
        
        /// =========================
        /// ESCOLHER TIPO
        /// =========================
        
        var enemy_type;
        
        
        // COMEÇO: só human
        if (progress < 0.1)
        {
            enemy_type = "human";
        }
        
        
        // LIBERA GHOST
        else if (progress < 0.4)
        {
            enemy_type = choose("human", "ghost");
        }
        
        
        // LIBERA BALL (40%+)
        else
        {
            enemy_type = choose("human", "ghost", "ball");
        }
        
        
        /// =========================
        /// AUMENTO DE GHOST APÓS 60%
        /// =========================
        
        if (progress >= 0.6)
        {
            if (irandom(100) < 30)
            {
                enemy_type = "ghost";
            }
        }
        
        
        /// =========================
        /// SPAWN
        /// =========================
        
        spawnw_enemy(side, enemy_type);
    }
}
