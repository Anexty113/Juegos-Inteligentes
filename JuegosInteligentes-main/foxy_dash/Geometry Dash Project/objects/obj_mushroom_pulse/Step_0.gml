var _on_mushroom = place_meeting(x,y, obj_player)

if(_on_mushroom) {
sprite_index = spr_mushroom_pulse_up
audio_play_sound(snd_mushroom,0, false)
with (obj_player) {
	
	if (inverted_gravity) {
	vspd = -obj_mushroom_pulse.jump
	} else {
	vspd = obj_mushroom_pulse.jump
	}
	boosted = true
}

} else {
	with (obj_player) boosted=false
}