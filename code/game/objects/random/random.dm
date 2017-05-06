/obj/random
	name = "Random Object"
	desc = "This item type is used to spawn random objects at round-start"
	icon = 'icons/misc/mark.dmi'
	icon_state = "rup"
	var/spawn_nothing_percentage = 0 // this variable determines the likelyhood that this random object will not spawn anything


// creates a new object and deletes itself
/obj/random/New()
	..()
	if (!prob(spawn_nothing_percentage))
		spawn_item()
	del src


// this function should return a specific item to spawn
/obj/random/proc/item_to_spawn()
	return 0


// creates the random item
/obj/random/proc/spawn_item()
	var/build_path = item_to_spawn()
	return (new build_path(src.loc))


/obj/random/tool
	name = "Random Tool"
	desc = "This is a random tool"
	icon = 'icons/obj/items.dmi'
	icon_state = "welder"
	item_to_spawn()
		return pick(/obj/item/weapon/screwdriver,\
					/obj/item/weapon/wirecutters,\
					/obj/item/weapon/weldingtool,\
					/obj/item/weapon/crowbar,\
					/obj/item/weapon/wrench,\
					/obj/item/device/flashlight)


/obj/random/technology_scanner
	name = "Random Scanner"
	desc = "This is a random technology scanner."
	icon = 'icons/obj/device.dmi'
	icon_state = "atmos"
	item_to_spawn()
		return pick(prob(5);/obj/item/device/t_scanner,\
					prob(2);/obj/item/device/radio,\
					prob(5);/obj/item/device/analyzer)


/obj/random/powercell
	name = "Random Powercell"
	desc = "This is a random powercell."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	item_to_spawn()
		return pick(prob(10);/obj/item/weapon/cell/crap,\
					prob(40);/obj/item/weapon/cell,\
					prob(40);/obj/item/weapon/cell/high,\
					prob(9);/obj/item/weapon/cell/super,\
					prob(1);/obj/item/weapon/cell/hyper)


/obj/random/bomb_supply
	name = "Bomb Supply"
	desc = "This is a random bomb supply."
	icon = 'icons/obj/assemblies/new_assemblies.dmi'
	icon_state = "signaller"
	item_to_spawn()
		return pick(/obj/item/device/assembly/igniter,\
					/obj/item/device/assembly/prox_sensor,\
					/obj/item/device/assembly/signaler,\
					/obj/item/device/multitool)


/obj/random/toolbox
	name = "Random Toolbox"
	desc = "This is a random toolbox."
	icon = 'icons/obj/storage.dmi'
	icon_state = "red"
	item_to_spawn()
		return pick(prob(3);/obj/item/weapon/storage/toolbox/mechanical,\
					prob(2);/obj/item/weapon/storage/toolbox/electrical,\
					prob(1);/obj/item/weapon/storage/toolbox/emergency)


/obj/random/tech_supply
	name = "Random Tech Supply"
	desc = "This is a random piece of technology supplies."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	spawn_nothing_percentage = 50
	item_to_spawn()
		return pick(prob(3);/obj/random/powercell,\
					prob(2);/obj/random/technology_scanner,\
					prob(1);/obj/item/weapon/packageWrap,\
					prob(2);/obj/random/bomb_supply,\
					prob(1);/obj/item/weapon/extinguisher,\
					prob(1);/obj/item/clothing/gloves/fyellow,\
					prob(3);/obj/item/weapon/cable_coil,\
					prob(2);/obj/random/toolbox,\
					prob(2);/obj/item/weapon/storage/belt/utility,\
					prob(5);/obj/random/tool)

/obj/random/maintenance
	name = "Random Maintenance Stuff"
	desc = "This is a random item."
	icon = 'icons/obj/items.dmi'
	icon_state = "latexballon_blow"
	spawn_nothing_percentage = 20
	item_to_spawn()
		return pick(prob(7);/obj/random/tech_supply,\
					prob(2);/obj/item/device/flashlight,\
					prob(1);/obj/item/weapon/storage/box/lights/mixed,\
					prob(1);/obj/item/clothing/glasses/sunglasses,\
					prob(2);/obj/item/clothing/mask/gas,\
					prob(1);/obj/item/weapon/lighter,\
					prob(1);/obj/item/weapon/mop,\
					prob(1);/obj/item/weapon/rack_parts,\
					prob(1);/obj/item/weapon/shovel,\
					prob(1);/obj/item/weapon/table_parts/wood,\
					prob(1);/obj/item/weapon/table_parts,\
					prob(1);/obj/item/weapon/tank/air,\
					prob(1);/obj/item/weapon/tank/emergency_oxygen,\
					prob(1);/obj/item/weapon/tank/emergency_oxygen/engi,\
					prob(1);/obj/item/weapon/wrapping_paper,\
					prob(1);/obj/item/weapon/dice,\
					prob(1);/obj/item/weapon/dice/d20,\
					prob(1);/obj/item/weapon/caution,\
					prob(2);/obj/item/weapon/cigbutt,\
					prob(1);/obj/item/weapon/camera_assembly,\
					prob(1);/obj/item/weapon/cane,\
					prob(3);/obj/item/weapon/extinguisher,\
					prob(1);/obj/item/toy/ammo/crossbow,\
					prob(1);/obj/item/taperoll/engineering,\
					prob(2);/obj/item/stack/rods,\
					prob(1);/obj/item/stack/medical/bruise_pack,\
					prob(1);/obj/item/stack/medical/ointment,\
					prob(1);/obj/item/stack/sheet/cardboard,\
					prob(1);/obj/item/stack/sheet/cloth,\
					prob(1);/obj/item/stack/sheet/wood,\
					prob(1);/obj/item/stack/sheet/glass,\
					prob(1);/obj/item/stack/tile/carpet,\
					prob(1);/obj/item/stack/tile/grass,\
					prob(1);/obj/item/stack/tile/wood,\
					prob(1);/obj/item/stack/tile,\
					prob(1);/obj/item/nutrient,\
					prob(1);/obj/item/bodybag,\
					prob(1);/obj/item/candle)

/obj/random/storage
	name = "Rack or closet or crate"
	desc = "This is a random item."
	icon = 'icons/obj/closet.dmi'
	icon_state = "syndicate1"
	item_to_spawn()
		return pick(prob(1);/obj/structure/closet,\
					prob(1);/obj/structure/closet/crate,\
					prob(1);/obj/structure/rack)