if (!transformation) {
	audio_play_sound(snd_fail,0, false)
	with(obj_game_manager){
		alarm_set(0, 1*game_get_speed(gamespeed_fps))
	}
}
