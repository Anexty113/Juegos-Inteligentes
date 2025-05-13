var _gui_w = display_get_gui_width()
var _gui_h = display_get_gui_height()

draw_set_halign(fa_center)
draw_text_transformed(_gui_w/2, 20, "Attemp " + string(attempts), 2, 2, 0)
draw_set_halign(fa_left)