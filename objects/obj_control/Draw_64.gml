if global.debug{
	draw_text(room_width / 2, 20, global.form)
}


//
draw_set_font(Font1)
draw_set_halign(fa_center)
draw_set_colour(c_black)

draw_text_transformed(display_get_gui_width() / 2 + 1, 13 + 1, string(floor(global.timer)), .4, .4, 0)

draw_set_colour(c_white)

draw_text_transformed(display_get_gui_width() / 2, 13, string(floor(global.timer)), .4, .4, 0)

draw_set_font(-1)



///
if global.defeat{
	var gw = display_get_gui_width();
	var gh = display_get_gui_height();

	var box_w = gw * 0.5;
	var box_h = gh * 0.1;

	var box_x = gw * 0.5 - box_w * 0.5;
	var box_y = gh * 0.75;
	
	draw_set_font(Font1)
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	/// Fundo
	draw_set_color(c_black);
	draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);

	/// Texto
	draw_set_color(c_white);

	draw_text_transformed(
	    box_x + box_w * 0.5,
	    box_y + box_h * 0.5,
	    "Enter Para Reiniciar",
		.4,
		.4,
		0
	);
	draw_set_font(-1)
}
