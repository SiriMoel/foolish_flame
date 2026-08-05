dofile_once("mods/foolish_flame/files/scripts/utils.lua")

bounty_attacks = {
    {
        id = "heat_loss_field",
        shard_sprite = "mods/foolish_flame/files/entities/misc/bounty/shard_sprites/heat_loss_field.png",
        func_init = function(entity, x, y)
            local child = EntityLoad("mods/foolish_flame/files/entities/misc/bounty/heat_loss_field.xml", x, y)
            EntityAddChild(entity, child)
        end,
    },
    {
        id = "laser_blast",
        shard_sprite = "mods/foolish_flame/files/entities/misc/bounty/shard_sprites/laser_blast.png",
        func_init = function(entity, x, y)
            local child = EntityLoad("mods/foolish_flame/files/entities/misc/bounty/laser_blast.xml", x, y)
            EntityAddChild(entity, child)
        end,
    },
    {
        id = "flares",
        shard_sprite = "mods/foolish_flame/files/entities/misc/bounty/shard_sprites/flares.png",
        func_init = function(entity, x, y)
            local child = EntityLoad("mods/foolish_flame/files/entities/misc/bounty/flares.xml", x, y)
            EntityAddChild(entity, child)
        end,
    },
    {
        id = "more_health",
        shard_sprite = "mods/foolish_flame/files/entities/misc/bounty/shard_sprites/more_health.png",
        func_init = function(entity, x, y)
            local comp = EntityGetFirstComponentIncludingDisabled(entity, "DamageModelComponent")
            if comp ~= nil then
                local hp = ComponentGetValue2(comp, "hp")
                local max_hp = ComponentGetValue2(comp, "max_hp")
                local hp_mult = 1.4
                ComponentSetValue2(comp, "hp", hp * hp_mult)
                ComponentSetValue2(comp, "max_hp", max_hp * hp_mult)
            end
        end,
    },
    {
        id = "flares_rapid",
        shard_sprite = "mods/foolish_flame/files/entities/misc/bounty/shard_sprites/flares.png",
        func_init = function(entity, x, y)
            local child = EntityLoad("mods/foolish_flame/files/entities/misc/bounty/flares_rapid.xml", x, y)
            EntityAddChild(entity, child)
        end,
    },
    {
        id = "damage",
        shard_sprite = "mods/foolish_flame/files/entities/misc/bounty/shard_sprites/damage.png",
        func_init = function(entity, x, y)
            EntityAddComponent2(entity, "LuaComponent", {
		        script_shot="mods/foolish_flame/files/entities/misc/bounty/damage.lua",
    		    execute_every_n_frame=-1
	        })
        end,
    },
}

function BountyAttacks(entity, x, y, attack_count)
    --local attacks = {}
    for i=1,attack_count do
        SetRandomSeed(x, y + i)
        local num = Random(1, #bounty_attacks)
        bounty_attacks[num].func_init(entity, x, y)
        --table.insert(attacks, bounty_attacks[num].id)
        EntityAddComponent2(entity, "SpriteParticleEmitterComponent", {
            _tags="ff_shard",
            sprite_file=bounty_attacks[num].shard_sprite or "mods/foolish_flame/files/entities/misc/bounty/shard_sprites/flares.png",
            sprite_centered=true,
            count_min=1,
            count_max=1,
            emission_interval_min_frames=1,
		    emission_interval_max_frames=1,
        })
    end
    --[[local str = ""
    for i=1,#attacks do
        str = str .. attacks[i]
        if i < #attacks then
            str = str .. ", "
        end
    end
    print("Added attacks " .. str .. " to FF bounty enemy")]]
end