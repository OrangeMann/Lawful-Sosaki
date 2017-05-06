/mob/living/carbon/brain/say(var/message)
	if (silent)
		return

	if(!(container && (istype(container, /obj/item/device/mmi) || istype(container, /obj/item/device/mmi/posibrain))))
		return //No MMI, can't speak, bucko./N
	else
		message = sanitize_simple(message)
		if ((department_radio_keys[copytext(message, 1, 3)] == "binary") && (container && istype(container, /obj/item/device/mmi/posibrain)))
			message = copytext(message, 3)
			message = trim(copytext(sanitize_uni(message), 1, MAX_MESSAGE_LEN))
			robot_talk(message)
			return
		if(prob(emp_damage*4))
			if(prob(10))
				return
			else
				message = stutter_uni(message)
		if(istype(container, /obj/item/device/mmi/radio_enabled))
			var/obj/item/device/mmi/radio_enabled/R = container
			if(R.radio)
				spawn(0) R.radio.hear_talk(src, sanitize_uni(message))
		..()