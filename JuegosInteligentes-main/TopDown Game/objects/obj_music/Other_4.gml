if (musica_actual != noone) {
	audio_stop_sound(musica_actual)
}

switch(room){
	case menu:
		musica_actual = audio_play_sound(snd_menu, 1, true)
		break
	case level1:
		musica_actual = audio_play_sound(snd_level1, 1, true)
		break
	case level2:
		musica_actual = audio_play_sound(snd_level2, 1, true)
		break
	case level3:
		musica_actual = audio_play_sound(snd_level3, 1, true)
		break
}