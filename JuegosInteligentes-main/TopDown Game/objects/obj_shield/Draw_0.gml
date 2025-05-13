if (active) {
    // Avanzar la animación del escudo
    image_speed = .75; // Velocidad normal de la animación
    var scale = shield_size / 100.0; // Escala basada en el tamaño
    draw_sprite_ext(
        shield_sprite,  // Sprite a dibujar
        -1,             // Subimagen actual, -1 usa automáticamente la animación
        x,              // Coordenada X
        y,              // Coordenada Y
        scale,          // Escala horizontal
        scale,          // Escala vertical
        0,              // Ángulo de rotación
        c_white,        // Color
        0.9             // Transparencia
    );
}
