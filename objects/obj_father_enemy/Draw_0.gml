///
image_alpha = 1
if global.form != form {
	image_alpha = .65
}


if form == "ghost"{
	gpu_set_texfilter(true)
	draw_self();
	gpu_set_texfilter(false)
}
else{
	draw_self()
}


///
if global.debug{
	draw_text(x, y - 30, life)
	draw_text(x, y - 50, state_current_txt)
}
