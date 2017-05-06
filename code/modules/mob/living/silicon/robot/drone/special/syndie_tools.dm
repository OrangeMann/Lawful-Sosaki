/obj/item/borg/modules_attacher
	name = "modules manager"
	desc = "This device can connect some items as modules."
	icon_state = "attacher"

	var/list/can_attach = list(
		/obj/item/device/t_scanner,
		/obj/item/device/healthanalyzer,
		/obj/item/device/analyzer,
		/obj/item/device/gps,

		/obj/item/device/hailer,
		/obj/item/weapon/bikehorn,
		/obj/item/toy/crayon,

		/obj/item/weapon/circular_saw,
		/obj/item/weapon/scalpel,

		/obj/item/weapon/storage/bag/ore,
		/obj/item/weapon/storage/bag/trash,

		/obj/item/device/flash,
		/obj/item/weapon/melee/baton,

		/obj/item/weapon/card/emag,
		/obj/item/weapon/gun/energy/crossbow,
		/obj/item/weapon/gun/projectile/pistol,
		/obj/item/weapon/gun/energy/taser/dual,
		/obj/item/weapon/gun/energy/gun/nuclear)

	var/list/attached = list()

/obj/item/borg/modules_attacher/proc/attach_module(var/obj/item/M, var/type, var/mob/living/silicon/robot/R)
	if(M.anchored) return
	attached[type] = M
	can_attach.Remove(type)
	M.loc = R.module
	R.module.modules.Add(M)
	R.visible_message("\red [R] grabs [M] and connects it to some wires!",
						"You grab [M] and connect it to your subsystems.")

/obj/item/borg/modules_attacher/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	return

/obj/item/borg/modules_attacher/afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag, params)
	if(!flag) return

	if(!isturf(target.loc))
		return

	for(var/item_type in can_attach)
		if(istype(target, item_type))
			attach_module(target, item_type, user)
			break

/obj/item/borg/modules_attacher/proc/drop_all_items(var/mob/living/silicon/robot/R)
	var/turf/T = get_turf(src)
	for(var/type in attached)
		can_attach.Add(type)

		var/obj/item/I = attached[type]
		if(!I) continue

		R.module.modules.Remove(I)
		I.loc = T






/obj/item/borg/charger
	name = "power connector"
	desc = "This device can drain power from power cells or recharge it."
	icon_state = "discharger"

	var/direction = 0 // 0 for IN, 1 for OUT
	var/is_in_use = 0

	var/list/stationary_chargers = list(
		/obj/machinery/cell_charger,
		/obj/machinery/recharger,
		/obj/machinery/mech_bay_recharge_port)

	var/list/chargeable_items = list(
		/obj/item/weapon/cell,
		/obj/item/weapon/gun/energy)

	var/list/deny_items = list(
		/obj/item/weapon/gun/energy/staff,
		/obj/item/weapon/gun/energy/gun/nuclear,
		/obj/item/weapon/gun/energy/crossbow)

/obj/item/borg/charger/attack_self(mob/user as mob)
	direction = !direction
	if(direction)
		user << "You switch [src] to CHARGE."
		icon_state = "recharger"
	else
		user << "You switch [src] to DRAIN."
		icon_state = "discharger"


/obj/item/borg/charger/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	return

/obj/item/borg/charger/afterattack(atom/target as mob|obj|turf|area, var/mob/living/silicon/robot/R, flag, params)
	if(!flag)	return
	if(!R.cell)	return
	if(in_use)	return

	if(!isturf(target.loc) && target.loc != R)
		return

	if(istype(target, /obj/machinery) && !direction)
		for(var/T in stationary_chargers)
			if(istype(target, T))
				charge_from_machine(target, R)
				break
		return

	else if(istype(target, /obj/item))
		for(var/T in chargeable_items)
			if(istype(target, T))
				for(var/T2 in deny_items)
					if(istype(target, T2)) return

				charge_item(target, R)
				break
		return

/obj/item/borg/charger/proc/charge_from_machine(var/obj/machinery/M, var/mob/living/silicon/robot/R)
	if(R.cell.charge >= R.cell.maxcharge)
		R << "Your cell is fully charged!"
		return

	if(!M.anchored)
		R << "\red [M] is disconnected!"
		return

	R.visible_message("\red [R] sticks [src] into [M]'s charging port and starts draining power from it!",
						"You connect to [M]'s charging port and start recharging your power cell.")

	is_in_use = 1
	while(is_in_use)
		if((M.stat & (BROKEN|NOPOWER)) || !M.anchored)
			break

		var/power_used = 40000
		power_used = R.cell.give(power_used*CELLRATE*0.95)
		M.use_power(power_used)

		if(!do_after(R, 10))
			break

	is_in_use = 0

	R.visible_message("\red [R] disconnects from [M]'s charging port.",
						"You disconnect from [M]'s charging port.")

/obj/item/borg/charger/proc/charge_item(var/obj/item/I, var/mob/living/silicon/robot/R)
	var/obj/item/weapon/cell/C
	if(istype(I, /obj/item/weapon/cell))
		C = I
	else
		C = locate(/obj/item/weapon/cell) in I

	if(!C) return

	if(!direction && C.charge <= 0)
		return

	var/silent = (I in R)

	if(!silent)
		R.visible_message("\red [R] sticks [src] into [I]'s charging port and starts [direction ? "charging" : "draining power from"] it!",
						"You connect to [I]'s charging port and start recharging [direction ? "it" : "your power cell"].")

	is_in_use = 1
	while(is_in_use)
		if(direction)
			if(C.charge >= C.maxcharge || R.cell.charge <= 0)
				break
		else
			if(C.charge <= 0 || R.cell.charge >= R.cell.maxcharge)
				break

		var/power_transfer = 100
		if(direction)
			power_transfer = min(power_transfer/2, R.cell.charge)
			if(R.cell.use(power_transfer))
				C.give(power_transfer)

		else
			power_transfer = min(power_transfer, C.charge)
			if(C.use(power_transfer))
				R.cell.give(power_transfer)

		I.update_icon()

		if(!do_after(R, 10))
			break

	is_in_use = 0

	if(!silent)
		R.visible_message("\red [R] disconnects from [I]'s charging port.",
							"You disconnect from [I]'s charging port.")

	return


/obj/item/borg/gripper/op
	name = "advanced gripper"
	overpowered = 1