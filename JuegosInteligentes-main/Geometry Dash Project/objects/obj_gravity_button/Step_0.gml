var _on_button = place_meeting(x,y, obj_player)

if (_on_button) {
	gravity_switched = true
	with (obj_player) {
		inverted_gravity = !inverted_gravity
		grav = -grav
		vspd = 0
		
		if (inverted_gravity) {
			y -= 75
			while (place_meeting(x,y, obj_wall_base)) y -= 1
			obj_gravity_button.sprite_index = spr_gravity_button_on
		} else {
			y += 75
			while (place_meeting(x,y, obj_wall_base)) y += 1
			obj_gravity_button.sprite_index = spr_gravity_button_off
		}
		
	}
	
} else {
	gravity_switched = false
}