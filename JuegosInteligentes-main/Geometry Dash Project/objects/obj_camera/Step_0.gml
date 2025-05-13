
if instance_exists(obj_player){
// Establecer posicion de la camara
var _target = instance_nearest(x, y, obj_player)

x = _target.x - (cam_w/2)
y = _target.y - (cam_h/2)

// Establecer limites para la camara
x = clamp(x, 0, room_width - cam_w)
y = clamp(y, 0, room_height - cam_h)
camera_set_view_pos(cam, x,y)

}