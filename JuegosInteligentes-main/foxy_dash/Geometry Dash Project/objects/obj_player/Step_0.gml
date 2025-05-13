//var _move = keyboard_check(vk_right) - keyboard_check(vk_left)
var _move = 1
var _jump = keyboard_check(vk_space)
var _jump_pressed = keyboard_check_pressed(vk_space);



hspd = _move* run_spd
vspd += grav

move_and_collide(hspd, vspd, obj_wall_base)

vspd = clamp(vspd, -max_vspd, max_vspd);

var _wall_in_front = place_meeting(x+1, y, obj_wall_base)

if (inverted_gravity){
	on_ground = place_meeting(x, y-1, obj_wall_base)
	var _below_ceiling = place_meeting(x, y+1, obj_wall_base)
} else {
	on_ground = place_meeting(x, y+1, obj_wall_base)
	var _below_ceiling = place_meeting(x, y-1, obj_wall_base)
}

// Verificar si el jugador está sobre una orb
if (place_meeting(x, y + 1, obj_jump_orb)) {
    double_jump = true;
} else {
    double_jump = false;
}

if (on_ground) {
    if (!boosted) {
        vspd = 0;
    } else {
        // Si el jugador fue impulsado, ya no está siendo impulsado
        boosted = false;
    }
}

//if (on_ground) {
//    if ((vspd > 0 && !inverted_gravity) || (vspd < 0 && inverted_gravity)) {
//        if (!boosted) {
//            vspd = 0;
//        }
//    }
//}

//saltos
if (on_ground && _jump) {
	audio_play_sound(snd_jump,0, false)
    if (inverted_gravity) {
        vspd = -jump; // Saltar hacia arriba (gravedad invertida)
    } else {
        vspd = jump;  // Saltar hacia arriba
    }
    has_double_jumped = false; // Restablecer el doble salto
}

// Si el jugador no está en el suelo, tiene doble salto disponible, se presionó la tecla de salto, y no ha realizado el doble salto aún
else if (!on_ground && double_jump && _jump_pressed && !has_double_jumped) {
	audio_play_sound(snd_jump,0, false)
    if (inverted_gravity) {
        vspd = -jump; // Doble salto hacia arriba (gravedad invertida)
    } else {
        vspd = jump;  // Doble salto hacia arriba
    }
    has_double_jumped = true; // Marcar que ya se realizó el doble salto
}


if ((vspd < 0 and _below_ceiling and !inverted_gravity) || (vspd > 0 and _below_ceiling and inverted_gravity)) {
	vspd = 0
}




// Cambio de sprites
if (_move != 0) {
    // El jugador está corriendo
    image_xscale = sign(_move);
    sprite_index = spr_player_run;
} else {
    // El jugador está parado
    sprite_index = spr_player_standing;
}

if (!on_ground) {
    if ((vspd < 0 && !inverted_gravity) || (vspd > 0 && inverted_gravity)) {
        sprite_index = spr_player_up;
    } else if ((vspd > 0 && !inverted_gravity) || (vspd < 0 && inverted_gravity)) {
        sprite_index = spr_player_fall;
    }
} 


//if (on_ground) vspd=0




if (_wall_in_front) {
instance_destroy()
}

// Destruir si se cae
if (y > 768 || y < 0) {
	instance_destroy()
}

image_yscale = inverted_gravity ? -1 : 1;



