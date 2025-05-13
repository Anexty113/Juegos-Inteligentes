var todos_oponentes_destruidos = true;

// Verificar los oponentes de los bots
with (obj_bot) {
    if (variable_instance_exists(id, "opponent")) {
        var opp = opponent;
        if (instance_exists(opp)) {
            // El oponente aún existe
            todos_oponentes_destruidos = false;
			//show_debug_message("El oponente del bot " + string(id) + " aún existe.")
        } 
    }
}

// Verificar los oponentes de los enemigos
with (obj_enemy) {
    if (variable_instance_exists(id, "opponent")) {
        var opp = opponent;
        if (instance_exists(opp)) {
            // El oponente aún existe
            todos_oponentes_destruidos = false;
			//show_debug_message("El oponente del enemigo " + string(id) + " aún existe.");
        }
    }
}

if (todos_oponentes_destruidos) {
   next_gen()
    // Proceder a iniciar la nueva generación
}
