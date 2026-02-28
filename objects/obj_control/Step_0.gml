/// Switch Debug
if keyboard_check_pressed(ord("D")){
	global.debug *= -1
}

///
if keyboard_check_pressed(vk_enter){
	spawnw_enemy(choose("left", "right"), "human")
}
