/obj/item/weapon/robot_module/drone/syndie
	name = "syndicate drone module"
	stacktypes = list(
		/obj/item/stack/sheet/wood/cyborg = 5,
		/obj/item/stack/sheet/mineral/plastic/cyborg = 5,
		/obj/item/stack/tile/wood = 10,
		/obj/item/stack/rods = 30,
		/obj/item/stack/tile/plasteel = 30,
		/obj/item/stack/sheet/metal/cyborg = 30,
		/obj/item/stack/sheet/plasteel = 20,
		/obj/item/stack/sheet/glass/cyborg = 30,
		/obj/item/stack/sheet/rglass/cyborg = 20,
		/obj/item/weapon/cable_coil = 40)

	New()
		modules += new /obj/item/weapon/pickaxe/plasmacutter(src)
		modules += new /obj/item/borg/sight/thermal(src)
		modules += new /obj/item/borg/sight/meson(src)
		modules += new /obj/item/weapon/handcuffs/cyborg(src)
		modules += new /obj/item/borg/charger(src)
		modules += new /obj/item/weapon/weldingtool/largetank(src)
		modules += new /obj/item/weapon/screwdriver(src)
		modules += new /obj/item/weapon/wrench(src)
		modules += new /obj/item/weapon/crowbar/red(src)
		modules += new /obj/item/weapon/wirecutters(src)
		modules += new /obj/item/device/multitool(src)
		modules += new /obj/item/device/lightreplacer(src)
		modules += new /obj/item/borg/gripper/op(src)
		modules += new /obj/item/borg/matter_decompiler(src)
		modules += new /obj/item/weapon/reagent_containers/spray/cleaner(src)

		emag = new /obj/item/borg/modules_attacher(src)

		for(var/T in stacktypes)
			var/obj/item/stack/sheet/W = new T(src)
			W.amount = stacktypes[T]
			src.modules += W

		return