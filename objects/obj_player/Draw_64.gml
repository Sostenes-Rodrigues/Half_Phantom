/// DEBUG
if global.debug{
	draw_text(20, 20, state_current_txt)
}

///
var pc;
pc = (life / life_max) * 100;
draw_healthbar(15, 10, 80, 16, pc, c_red, c_red, c_red, 0, false, true)

pc = (life_phantom / life_phantom_max) * 100;
draw_healthbar(15, 20, 80, 26, pc, c_lime, c_lime, c_lime, 0, false, true)


///
draw_set_alpha(global.effect_screen)
draw_rectangle_colour(0, 0, display_get_gui_width(), display_get_gui_height(), ef_col1, ef_col2, ef_col3, ef_col4, false)
global.effect_screen = lerp(global.effect_screen, 0, .1)
draw_set_alpha(1)
