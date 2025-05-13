if(instance_exists(target1)){
	var _target = target1
} else if (instance_exists(target2)) {
	var _target = target2
} else {
	exit;
}

// Establecer posicion de la camara
x = _target.x - (cam_w/2)
y = _target.y - (cam_h/2)

// Establecer limites para la camara
x = clamp(x, 0, room_width - cam_w)
y = clamp(y, 0, room_height - cam_h)
camera_set_view_pos(cam, x,y)