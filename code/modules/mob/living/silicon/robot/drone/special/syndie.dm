/mob/living/silicon/robot/drone/syndie
	icon = 'icons/mob/robots_a.dmi'
	icon_state = "syndiebot"
	maxHealth = 60
	health = 60
	emagged = 0
	req_access = list()

	var/friend_name = ""

/mob/living/silicon/robot/drone/syndie/New()
	..()
	if(camera && camera.network.len)
		camera.network.Cut()

	cell.maxcharge = 15000
	cell.charge = 15000

	module = new /obj/item/weapon/robot_module/drone/syndie(src)
	laws = new /datum/ai_laws/syndicate_override

	//Some tidying-up.
	flavor_text = "It's a tiny red drone. It has no manufacturer logo on it."
	updateicon()

/mob/living/silicon/robot/drone/syndie/updatename()
	real_name = "strange maintenance drone"
	name = real_name

/mob/living/silicon/robot/drone/syndie/law_resync()
	return

/mob/living/silicon/robot/drone/syndie/shut_down()
	return


/mob/living/silicon/robot/drone/syndie/death(gibbed)
	if(module)
		var/obj/item/borg/modules_attacher/A = locate(/obj/item/borg/modules_attacher) in module
		if(A) A.drop_all_items(src)

		A = locate(/obj/item/borg/modules_attacher) in src
		if(A) A.drop_all_items(src)
	..(gibbed)

/mob/living/silicon/robot/drone/syndie/question(var/client/C)
	spawn(0)
		if(!C || jobban_isbanned(C,"Cyborg") || jobban_isbanned(C, "Syndicate"))
			return
		var/response = alert(C, "Someone is attempting to launch a Syndicate drone. Would you like to play as one?", "Syndicate drone launched", "Yes", "No", "Never for this round.")
		if(!C || ckey)
			return
		if(response == "Yes")
			transfer_personality(C)
		else if (response == "Never for this round")
			C.prefs.be_special ^= BE_PAI

/mob/living/silicon/robot/drone/syndie/transfer_personality(var/client/player)
	if(!player) return

	src.ckey = player.ckey

	if(player.mob && player.mob.mind)
		player.mob.mind.transfer_to(src)

	lawupdate = 0
	emagged = 1
	src << "<b>Systems rebooted</b>. Loading base pattern S-013 protocol... <b>loaded</b>."
	full_law_reset()
	src << "Use <b>:d</b> to talk to other drones and <b>say</b> to speak silently to your nearby fellows."
	if(friend_name)
		src << "\red \b ALERT: [friend_name] is your new master. Obey your new laws and his commands."
		friend_name = ""

/mob/living/silicon/robot/drone/syndie/full_law_reset()
	clear_supplied_laws()
	clear_inherent_laws()
	clear_ion_laws()
	laws = new /datum/ai_laws/syndicate_override
	if(friend_name)
		set_zeroth_law("Only [friend_name] and people he designates as being such are Syndicate Agents.")


/mob/living/silicon/robot/drone/syndie/attack_hand(mob/living/carbon/human/M as mob)
	if(!electrocute_mob(M, cell, src, 0.8) && M.a_intent != "help")
		..()

/mob/living/silicon/robot/drone/syndie/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(stat == DEAD && (istype(W, /obj/item/weapon/card/id) || istype(W, /obj/item/device/pda)))
		friend_name = user.real_name
	..()




/mob/living/silicon/robot/drone/syndie/auto_request_player/New()
	..()
	request_player()


/mob/living/silicon/robot/drone/syndie/off
	stat = DEAD