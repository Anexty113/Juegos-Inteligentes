if aimDir >=45 && aimDir < 135 && !ismelee
{
draw_weapon()
}

draw_self();

if (aimDir >= 135 && !ismelee) || (aimDir < 45 && !ismelee)
{
draw_weapon()
}

// Verifica si la variable shield_instance está definida (es decir, si el escudo existe)
if (shield_instance != undefined) {
    // Verifica si el escudo está activo
    with (shield_instance) {
        if (active) {
            // Aquí llamas al código del escudo, tal como lo tienes configurado en su evento Draw
            image_speed = 1; // Velocidad normal de la animación
            var scale = shield_size / 100.0; // Escala basada en el tamaño
            draw_sprite_ext(
                shield_sprite,  // El sprite del escudo
                -1,             // Usamos -1 para la animación automática
                x,              // Coordenada X del escudo
                y,              // Coordenada Y del escudo
                scale,          // Escala horizontal
                scale,          // Escala vertical
                0,              // Ángulo de rotación
                c_white,        // Color (blanco)
                0.75            // Transparencia
            );
        }
    }
}

draw_text(x, y, string(hp) )
