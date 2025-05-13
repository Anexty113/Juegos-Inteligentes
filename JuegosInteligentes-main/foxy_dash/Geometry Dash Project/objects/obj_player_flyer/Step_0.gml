//var _move = keyboard_check(vk_right) - keyboard_check(vk_left)
var _move = 1
var _jump = keyboard_check(vk_space)
var _below_ceiling = place_meeting(x,y-1, obj_wall_base)


hspd = _move* run_spd
vspd += grav

move_and_collide(hspd, vspd, obj_wall_base)

vspd = clamp(vspd, -max_vspd, max_vspd);

var _wall_in_front = place_meeting(x+1, y, obj_wall_base)

if (_jump) vspd += jump;

if (vspd < 0 and _below_ceiling ) {
	vspd = 0
}


//if (on_ground) vspd=0

if (_wall_in_front) {
instance_destroy()
}



