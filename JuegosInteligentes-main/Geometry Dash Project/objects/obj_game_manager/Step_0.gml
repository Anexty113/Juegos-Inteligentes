if(instance_number(obj_bot)==0)
	{
		if instance_exists(obj_mushroom_pulse)
		{
			with (obj_mushroom_pulse)
			{
				sprite_index = spr_mushroom_pulse_down
			}
		}
		next_gen()
	}