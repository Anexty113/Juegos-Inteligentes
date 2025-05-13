/// @description Insert description here
// You can write your code in this editor
draw_self()

if dist_to_spike < spike_detection_range 
{
	draw_line_width_color(x, bbox_bottom - 10, x+dist_to_spike, bbox_bottom-10, 2, c_red, c_red)
}

if dist_to_wall < wall_detection_range 
{
	draw_line_width_color(x, bbox_bottom - 10, x+dist_to_wall, bbox_bottom-10, 2, c_blue, c_blue)
}

if dist_to_spike < spike_detection_range 
{
	draw_line_width_color(x, bbox_bottom-yoffset, x+dist_to_spike, bbox_bottom-yoffset, 2, c_red, c_red)
}

if dist_to_spike < spike_detection_range 
{
	draw_line_width_color(x, bbox_bottom+yoffset, x+dist_to_spike, bbox_bottom+yoffset, 2, c_red, c_red)
}
