/*
/// Switch Debug
if keyboard_check_pressed(ord("D")){
	global.debug *= -1
	show_debug_message(global.debug)
}
*/


///
if keyboard_check_pressed(ord("E")) {
	game_end()
}


if global.defeat{
	// Só reinicia quando apertar Enter
	if (keyboard_check_pressed(vk_enter))
	{
	    global.form = "human"
		
		room_restart();
	}
	
	
	exit
}




///
if global.timer > 0 or instance_exists(obj_father_enemy){
	control_spawner()
}
else{
	room_goto(rm_end)
}
