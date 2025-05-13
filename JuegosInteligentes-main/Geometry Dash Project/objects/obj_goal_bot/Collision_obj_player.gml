ds_list_add(obj_game_manager.best_w,  other.neuronal_network.w)
ds_list_add(obj_game_manager.best_b, other.neuronal_network.b)

show_debug_message("Se ejecuto el obj_goal_bot")
show_debug_message("w = "+ string(other.neuronal_network.w))
show_debug_message("b = "+ string(other.neuronal_network.b))

obj_game_manager.save_parameters("parametros2.json")
room_goto(menu)