//draw_text_transformed(20,20, "hspd = " + string(hspd), 2, 2, 0)
//draw_text_transformed(20,60, "vspd = " + string(vspd), 2, 2, 0)

//draw_text(20, 100, "Wall in front: " + string(_wall_in_front));
//draw_text(20, 140,"vspd: " + string(vspd));
//draw_text(20, 180, "Inverted Gravity: " + string(inverted_gravity));
//draw_text(20, 220, "Transformation " + string(transformation));
//draw_text(20, 260, "Double jump " + string(double_jump));



//draw_text_transformed(20,20, "dist_to_spike = "+string(1-(dist_to_spike/1000)), 2,2,0)
//draw_text_transformed(20,60, "dist_to_wall = "+string(1-(dist_to_wall/1000)), 2,2,0)

draw_text_transformed(20,20, "dist_all = "+string(1-(dist_all/1000)), 2,2,0)

draw_text_transformed(20,100, "dist_to_floor = "+string(1-(dist_to_floor/200)), 2,2,0)
//draw_text_transformed(20,140, "dist_to_ceil = "+string((1-(dist_to_ceil/100))*-1), 2,2,0)
draw_text_transformed(20,140, "dist_to_ceil = "+string(over_ceil), 2,2,0)

//draw_text_transformed(20,180, "spike height = "+string(spike_height/34), 2,2,0)
//draw_text_transformed(20,220, "spike width = "+string(spike_width/30), 2,2,0)

draw_text_transformed(20,260, "up = "+string(1-(dist_up/1000)), 2,2,0)
draw_text_transformed(20,300, "down = "+string(1-(dist_down/1000)), 2,2,0)

draw_text_transformed(20,340, "dist_to_mushroom = "+string(1-(dist_to_mushroom/1000)), 2,2,0)
draw_text_transformed(20,380, "over_orb = "+string(on_orb_n), 2,2,0)

draw_text_transformed(20,420, "transformation = "+string(transformation_n), 2,2,0)


//draw_text_transformed(20,220, "spike dist y = "+string(dist_to_spike_y/200), 2,2,0)