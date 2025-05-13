spd = 1.75;

if (instance_exists(opponent)) {
    var dx = x - opponent.x; // Desplazamiento hacia el oponente
    var dy = y - opponent.y;
    var distance = sqrt(dx * dx + dy * dy); // Distancia al oponente

    if (hp > 7 or !instance_exists(obj_foodparent)) && distance >= detection_radius {
        // Seguir al oponente
        mp_potential_step_object(opponent.x, opponent.y, spd, obj_wall);
        dir = point_direction(x, y, opponent.x, opponent.y);
    }

    if (hp > 7 or !instance_exists(obj_foodparent)) && distance <= escape_radius && distance > melee_radius {
        // Calcular dirección opuesta
        if (distance > 0) {
            dx /= distance; // Normalizar dirección
            dy /= distance;

            var opposite_x = x + dx * 100; // Punto opuesto en el plano
            var opposite_y = y + dy * 100;

            mp_potential_step_object(opposite_x, opposite_y, spd -1 , obj_wall);
            dir = point_direction(x, y, opposite_x, opposite_y);
        }
    }

    if (hp > 7 or !instance_exists(obj_foodparent)) && distance <= melee_radius {
        // Atacar al oponente (en rango cuerpo a cuerpo)
        mp_potential_step_object(opponent.x, opponent.y, spd, obj_wall);
        dir = point_direction(x, y, opponent.x, opponent.y);
    }

    if (hp > 7 or !instance_exists(obj_foodparent)) && distance < detection_radius && distance > escape_radius {
        spd = 0;

        // Atacar a distancia si el cooldown está listo
        if (cooldownTimer == 0) {
            var _bulletInst = instance_create_depth(x, y, depth - 100, obj_enemybullet_2);
            dir = point_direction(x, y, opponent.x, opponent.y);

            with (_bulletInst) {
                dir = other.dir;
            }
            cooldownTimer = 120;
        }

        // Reducir cooldown
        if (cooldownTimer > 0) {
            cooldownTimer--;
        }
    }

    if (instance_exists(obj_foodparent) && hp <= 7) {
        // Ir hacia la comida si la salud es baja
        mp_potential_step_object(obj_foodparent.x, obj_foodparent.y, spd, obj_wall);
        dir = point_direction(x, y, obj_foodparent.x, obj_foodparent.y);
    }
}

xspd = lengthdir_x(spd, dir);
yspd = lengthdir_y(spd, dir);

if (xspd == 0 && yspd == 0) {
    image_index = 0;
}

// Corregir orientación
if (xspd > 0) { face = -1; }
else { face = 1; }
image_xscale = face;

// Colisiones
if (place_meeting(x + xspd, y, obj_wall) or place_meeting(x + xspd, y, obj_enemyParent) or place_meeting(x + xspd, y, obj_shield)) {
    xspd = 0;
}

if (place_meeting(x, y + yspd, obj_wall) or place_meeting(x, y + yspd, obj_enemyParent) or place_meeting(x + xspd, y, obj_shield)) {
    yspd = 0;
}

x += xspd;
y += yspd;

// Heredar
event_inherited();
