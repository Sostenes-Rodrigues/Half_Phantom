///
image_alpha = 1
if global.form != form {
	image_alpha = .65
}
draw_self()

///
if global.debug{
	draw_text(x, y - 30, life)
}
