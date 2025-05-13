if (!activo) {
	
	if instance_exists(obj_player) {
		var jugador = obj_player
	}
	else if instance_exists(obj_player_flyer) {
		var jugador = obj_player_flyer
	} else {
	var jugador = noone
	}
    if (instance_exists(jugador)) {
        // Verificar si el jugador ha alcanzado la posición X específica
        if (x - jugador.x <= obj_camera.cam_w) { // Cambia 500 por la posición X deseada
            activo = true; // Activar el enemigo
        }
    }
} else {
    // Si el enemigo está activo, moverlo en la dirección establecida
    x += lengthdir_x(vspd, direccion);
    y += lengthdir_y(vspd, direccion);

    if (x > room_width + sprite_width || x < -sprite_width) {
        vspd=0;
		image_speed = 0
    }
}
