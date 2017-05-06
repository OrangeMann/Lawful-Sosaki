/obj/item/weapon/gun/energy/taser/dual
	name = "taser gun"
	desc = "A small, low capacity gun used for non-lethal takedowns."
	icon = 'icons/newgreen/guns.dmi'
	icon_state = "taser"
	item_state = "taser"
	projectile_type = "/obj/item/projectile/energy/tasershot"
	modifystate = "taserold"

	var/tasermode = 1 //1 = stun, 0 = pain

	attack_self(mob/living/user as mob)
		switch(tasermode)
			if(0)
				tasermode = 1
				fire_sound = 'sound/weapons/Taser.ogg'
				user << "\red [src.name] is now set to stun."
				projectile_type = "/obj/item/projectile/energy/tasershot"
				modifystate = "taserold"
			if(1)
				tasermode = 0
				fire_sound = 'sound/weapons/Laser.ogg'
				user << "\red [src.name] is now set to pain."
				projectile_type = "/obj/item/projectile/beam/stun"
				modifystate = "tasernew"
		update_icon()

/obj/item/weapon/gun/energy/taser/old
	name = "taser gun"
	desc = "R.I.O.T. NT Taser. One mode, x2 more charges, x1.5 more powerfull."
	icon = 'icons/newgreen/guns.dmi'
	icon_state = "taser"
	charge_cost = 50
	projectile_type = "/obj/item/projectile/energy/tasershot/power"

/obj/item/projectile/energy/tasershot
	name = "electrode"
	icon_state = "spark"
	pass_flags = PASSTABLE
	nodamage = 1
	stun = 6
	weaken = 6
	stutter = 12
	damage_type = HALLOSS

/obj/item/projectile/energy/tasershot/power
	name = "electrode"
	icon_state = "spark"
	pass_flags = PASSTABLE
	nodamage = 1
	stun = 9
	weaken = 9
	stutter = 18
	damage_type = HALLOSS


/obj/item/projectile/energy/tasershot/shell
	name = "electrode"
	icon_state = "spark"
	pass_flags = PASSTABLE
	nodamage = 1
	stun = 9
	weaken = 9
	stutter = 18
	damage_type = HALLOSS
