/turf/simulated/floor/darkfloor
	name = "floor"
	icon = 'icons/newgreen/greenfloors.dmi'
	icon_state = "darkfull"

/turf/simulated/floor/airless
	icon_state = "floor"
	name = "airless floor"
	oxygen = 0.01
	nitrogen = 0.01
	temperature = TCMB

	New()
		..()
		name = "floor"

/turf/simulated/floor/airless/ceiling
	icon_state = "rockvault"

/turf/simulated/floor/light
	name = "Light floor"
	luminosity = 5
	icon_state = "light_on"
	floor_tile = new/obj/item/stack/tile/light

	New()
		floor_tile.New() //I guess New() isn't run on objects spawned without the definition of a turf to house them, ah well.
		var/n = name //just in case commands rename it in the ..() call
		..()
		spawn(4)
			if(src)
				update_icon()
				name = n



/turf/simulated/floor/wood
	name = "floor"
	icon_state = "wood"
	floor_tile = new/obj/item/stack/tile/wood

/turf/simulated/floor/vault
	icon_state = "rockvault"

	New(location,type)
		..()
		icon_state = "[type]vault"

/turf/simulated/wall/vault
	icon_state = "rockvault"

	New(location,type)
		..()
		icon_state = "[type]vault"

/turf/simulated/floor/engine
	name = "reinforced floor"
	icon_state = "engine"
	thermal_conductivity = 0.025
	heat_capacity = 325000

/turf/simulated/floor/engine/attackby(obj/item/weapon/C as obj, mob/user as mob)
	if(!C)
		return
	if(!user)
		return
	if(istype(C, /obj/item/weapon/wrench))
		user << "\blue Removing rods..."
		playsound(src, 'sound/items/Ratchet.ogg', 80, 1)
		if(do_after(user, 30))
			new /obj/item/stack/rods(src, 2)
			ChangeTurf(/turf/simulated/floor)
			var/turf/simulated/floor/F = src
			F.make_plating()
			return

/turf/simulated/floor/engine/cult
	name = "engraved floor"
	icon_state = "cult"


/turf/simulated/floor/engine/n20
	New()
		. = ..()
		var/datum/gas_mixture/adding = new
		var/datum/gas/sleeping_agent/trace_gas = new

		trace_gas.moles = 2000
		adding.trace_gases += trace_gas
		adding.temperature = T20C

		assume_air(adding)

/turf/simulated/floor/engine/vacuum
	name = "vacuum floor"
	icon_state = "engine"
	oxygen = 0
	nitrogen = 0.001
	temperature = TCMB

/turf/simulated/floor/plating
	name = "plating"
	icon_state = "plating"
	floor_tile = null
	intact = 0

/turf/simulated/floor/plating/airless
	icon_state = "plating"
	name = "airless plating"
	oxygen = 0.01
	nitrogen = 0.01
	temperature = TCMB

	New()
		..()
		name = "plating"

/turf/simulated/floor/bluegrid
	icon = 'icons/turf/floors.dmi'
	icon_state = "bcircuit"

/turf/simulated/floor/greengrid
	icon = 'icons/turf/floors.dmi'
	icon_state = "gcircuit"


/turf/simulated/shuttle
	name = "shuttle"
	icon = 'icons/turf/shuttle.dmi'
	thermal_conductivity = 0.05
	heat_capacity = 0
	layer = 2

/turf/simulated/shuttle/wall
	name = "wall"
	icon_state = "wall1"
	opacity = 1
	density = 1
	blocks_air = 1

/turf/simulated/shuttle/floor
	name = "floor"
	icon_state = "floor"

/turf/simulated/shuttle/plating
	name = "plating"
	icon = 'icons/turf/floors.dmi'
	icon_state = "plating"

/turf/simulated/shuttle/plating/vox	//Vox skipjack plating
	oxygen = 0
	nitrogen = MOLES_N2STANDARD + MOLES_O2STANDARD

/turf/simulated/shuttle/floor4 // Added this floor tile so that I have a seperate turf to check in the shuttle -- Polymorph
	name = "Brig floor"        // Also added it into the 2x3 brig area of the shuttle.
	icon_state = "floor4"

/turf/simulated/shuttle/floor4/vox	//Vox skipjack floors
	name = "skipjack floor"
	oxygen = 0
	nitrogen = MOLES_N2STANDARD + MOLES_O2STANDARD

/turf/simulated/floor/beach
	name = "Beach"
	icon = 'icons/misc/beach.dmi'

/turf/simulated/floor/beach/sand
	name = "Sand"
	icon_state = "sand"

/turf/simulated/floor/beach/coastline
	name = "Coastline"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "sandwater"

/turf/simulated/floor/beach/water
	name = "Water"
	icon_state = "water"

/turf/simulated/floor/beach/water/New()
	..()
	overlays += image("icon"='icons/misc/beach.dmi',"icon_state"="water5","layer"=MOB_LAYER+0.1)

/turf/simulated/floor/grass
	name = "Grass patch"
	icon_state = "grass1"
	floor_tile = new/obj/item/stack/tile/grass

	New()
		floor_tile.New() //I guess New() isn't ran on objects spawned without the definition of a turf to house them, ah well.
		icon_state = "grass[pick("1","2","3","4")]"
		..()
		spawn(4)
			if(src)
				update_icon()
				for(var/direction in cardinal)
					if(istype(get_step(src,direction),/turf/simulated/floor))
						var/turf/simulated/floor/FF = get_step(src,direction)
						FF.update_icon() //so siding get updated properly

/turf/simulated/floor/carpet
	name = "Carpet"
	icon_state = "carpet"
	floor_tile = new/obj/item/stack/tile/carpet

	New()
		floor_tile.New() //I guess New() isn't ran on objects spawned without the definition of a turf to house them, ah well.
		if(!icon_state)
			icon_state = "carpet"
		..()
		spawn(4)
			if(src)
				update_icon()
				for(var/direction in list(1,2,4,8,5,6,9,10))
					if(istype(get_step(src,direction),/turf/simulated/floor))
						var/turf/simulated/floor/FF = get_step(src,direction)
						FF.update_icon() //so siding get updated properly



/turf/simulated/floor/plating/ironsand/New()
	..()
	name = "Iron Sand"
	icon_state = "ironsand[rand(1,15)]"

/turf/simulated/floor/plating/snow
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"

/turf/simulated/floor/plating/snow/ex_act(severity)
	return

/turf/simulated/floor/color/white/
	icon_state = "white"
/turf/simulated/floor/color/white/white
	icon_state = "white"
/turf/simulated/floor/color/white/white/side
	icon_state = "whitehall"
/turf/simulated/floor/color/white/white/corner
	icon_state = "whitecorner"
/turf/simulated/floor/color/white/red
	icon_state = "whiteredfull"
/turf/simulated/floor/color/white/red/side
	icon_state = "whitered"
/turf/simulated/floor/color/white/red/corner
	icon_state = "whiteredcorner"
/turf/simulated/floor/color/white/blue
	icon_state = "whitebluefull"
/turf/simulated/floor/color/white/blue/side
	icon_state = "whiteblue"
/turf/simulated/floor/color/white/blue/corner
	icon_state = "whitebluecorner"
/turf/simulated/floor/color/white/green
	icon_state = "whitegreenfull"
/turf/simulated/floor/color/white/green/side
	icon_state = "whitegreen"
/turf/simulated/floor/color/white/green/corner
	icon_state = "whitegreencorner"
/turf/simulated/floor/color/white/yellow
	icon_state = "whiteyellowfull"
/turf/simulated/floor/color/white/yellow/side
	icon_state = "whiteyellow"
/turf/simulated/floor/color/white/yellow/corner
	icon_state = "whiteyellowcorner"
/turf/simulated/floor/color/white/purple
	icon_state = "whitepurplefull"
/turf/simulated/floor/color/white/purple/side
	icon_state = "whitepurple"
/turf/simulated/floor/color/white/purple/corner
	icon_state = "whitepurplecorner"

/turf/simulated/floor/color/red
	icon_state = "redfull"
/turf/simulated/floor/color/red/side
	icon_state = "red"
/turf/simulated/floor/color/red/corner
	icon_state = "redcorner"

/turf/simulated/floor/color/blue
	icon_state = "bluefull"
/turf/simulated/floor/color/blue/side
	icon_state = "blue"
/turf/simulated/floor/color/blue/corner
	icon_state = "bluecorner"

/turf/simulated/floor/color/green
	icon_state = "greenfull"
/turf/simulated/floor/color/green/side
	icon_state = "green"
/turf/simulated/floor/color/green/corner
	icon_state = "greencorner"

/turf/simulated/floor/color/yellow
	icon_state = "yellowfull"
/turf/simulated/floor/color/yellow/side
	icon_state = "yellow"
/turf/simulated/floor/color/yellow/corner
	icon_state = "yellowcorner"

/turf/simulated/floor/color/neutral
	icon_state = "neutralfull"
/turf/simulated/floor/color/neutral/side
	icon_state = "neutral"
/turf/simulated/floor/color/neutral/corner
	icon_state = "neutralcorner"

/turf/simulated/floor/color/orange
	icon_state = "orangefull"
/turf/simulated/floor/color/orange/side
	icon_state = "orange"
/turf/simulated/floor/color/orange/corner
	icon_state = "orangecorner"

/turf/simulated/floor/color/purple
	icon_state = "purplefull"
/turf/simulated/floor/color/purple/side
	icon_state = "purple"
/turf/simulated/floor/color/purple/corner
	icon_state = "purplecorner"

/turf/simulated/floor/color/black
	icon_state = "blackside"
/turf/simulated/floor/color/black/corner
	icon_state = "blackcorner"

//turf/simulated/floor/color/warning
	//icon_state "warning"

//turf/simulated/floor/color/warning/corner
	//icon_state "warningcorner"
