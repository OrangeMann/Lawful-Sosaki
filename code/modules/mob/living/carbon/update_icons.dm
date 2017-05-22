//LOOK G-MA, I'VE JOINED CARBON PROCS THAT ARE IDENTICAL IN ALL CASES INTO ONE PROC, I'M BETTER THAN LIFE()
//I thought about mob/living but silicons and simple_animals don't want this just yet.
//Right now just handles lying down, but could handle other cases later.
//IMPORTANT: Multiple animate() calls do not stack well, so try to do them all at once if you can.
/mob/living/carbon/update_transform()
	var/matrix/ntransform = matrix(transform) //aka transform.Copy()
	var/final_pixel_y = pixel_y
	var/final_dir = dir
	var/changed = 0
	var/anim_time = 2

	if(lying != lying_prev)
		changed++
		ntransform.TurnTo(lying_prev,lying)
	if(lying == 0) //Lying to standing
		final_pixel_y = get_standard_pixel_y_offset()

	else if(lying != 0 && lying_prev != 0)//we were lying and are still lying. The difference was caused by crawling direction change
		anim_time = 0//animate that instantly, not a 0.2-second-long backflip; those are awkward when you're dying

	else //if(lying != 0)
		if(lying_prev == 0) //Standing to lying
			pixel_y = get_standard_pixel_y_offset()
			final_pixel_y = get_standard_pixel_y_offset(lying)
			if(dir & (EAST|WEST)) //Facing east or west
				final_dir = pick(NORTH, SOUTH) //So you fall on your side rather than your face or ass
	lying_prev = lying	//so we don't try to animate until there's been another change.

	if(changed)
		animate(src, transform = ntransform, time = anim_time, pixel_y = final_pixel_y, dir = final_dir, easing = EASE_IN|EASE_OUT)
		animate(src, transform = ntransform, time = 2, pixel_y = final_pixel_y, dir = final_dir, easing = EASE_IN|EASE_OUT)