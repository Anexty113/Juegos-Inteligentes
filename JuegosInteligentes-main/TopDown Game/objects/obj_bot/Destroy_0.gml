show_debug_message("Bot destruido w = "+string(neuronal_network.w))
show_debug_message("Bot destruido b = "+string(neuronal_network.b))
show_debug_message("Bot destruido fitness = "+string(fitness))

ds_list_add(obj_game_manager.best_w, neuronal_network.w)
ds_list_add(obj_game_manager.best_b, neuronal_network.b)
ds_list_add(obj_game_manager.best_fitness, fitness)

neuronal_network.w = undefined;
neuronal_network.b = undefined;
instance_destroy(neuronal_network)