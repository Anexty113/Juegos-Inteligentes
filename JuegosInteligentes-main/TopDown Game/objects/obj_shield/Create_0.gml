// Variables para el escudo
target = noone;         // Objeto que el escudo protege
shield_max_time = 20;   // Duración máxima del escudo en segundos
shield_time = shield_max_time;
shield_cooldown_time = 3; // Cooldown en segundos (ahora manejado por el objeto que llama al escudo)
shield_size = 100;      // Tamaño inicial del escudo (en porcentaje)
shield_sprite = spr_shield; // Sprite del escudo
active = false;         // Indica si el escudo está activo
