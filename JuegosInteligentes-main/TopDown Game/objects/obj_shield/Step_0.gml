// Si el escudo está activo y sigue a su objetivo
if (target != noone && active) {
    x = target.x;
    y = target.y;

    // Reducir tiempo del escudo
    shield_time -= 1 / 30; // Ajusta según la velocidad del room
    shield_size = max(10, (shield_time / shield_max_time) * 100); // Reducir tamaño proporcionalmente

    // Desactivar el escudo si se agotó el tiempo
    if (shield_time <= 0) {
		if (variable_instance_exists(target, "shield_active")) 
		{
		target.shield_active = false
		target.cooldown_action = 120
		}
		instance_destroy(); // Destruir el escudo
    }
} else {
    instance_destroy(); // Destruir el escudo si no está activo o sin objetivo
}

// Si el escudo recibe daño (colisión con una bala)
if (place_meeting(x, y, obj_demageParent)) {
    shield_time -= 1; // Reducir el tiempo del escudo al recibir daño
    if (shield_time <= 0) {
		if (variable_instance_exists(target, "shield_active")) 
		{
		target.shield_active = false
		target.cooldown_action = 120
		}
		instance_destroy(); // Destruir el escudo cuando se acabe el tiempo
    }
}
