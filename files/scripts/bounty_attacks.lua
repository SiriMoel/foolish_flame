dofile_once("mods/foolish_flame/files/scripts/utils.lua")

bounty_attacks = {
    {
        id = "two",
        shard_sprite = "mods/foolish_flame/files/entities/misc/bounty/shard_sprites/two.png",
        func_init = function(entity, x, y)
            for i=1,2 do
                SetRandomSeed(y + entity, x + i)
                local num = Random(2, #bounty_attacks) -- can't add this
                AddBountyAttack(entity, x, y, num) 
            end
        end,
    },
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
    {
        id = "hypixelskyblockvoodoodoll",
        shard_sprite = "mods/foolish_flame/files/entities/misc/bounty/shard_sprites/hypixelskyblockvoodoodoll.png",
        func_init = function(entity, x, y)
            local child = EntityLoad("mods/foolish_flame/files/entities/misc/bounty/hypixelskyblockvoodoodoll.xml", x, y)
            EntityAddChild(entity, child)
        end,
    },
    {
        id = "homing_attack",
        shard_sprite = "mods/foolish_flame/files/entities/misc/bounty/shard_sprites/homing_attack.png",
        func_init = function(entity, x, y)
            local child = EntityLoad("mods/foolish_flame/files/entities/misc/bounty/homing_attack.xml", x, y)
            EntityAddChild(entity, child)
        end,
    },
    {
        id = "slash",
        shard_sprite = "mods/foolish_flame/files/entities/misc/bounty/shard_sprites/slash.png",
        func_init = function(entity, x, y)
            local child = EntityLoad("mods/foolish_flame/files/entities/misc/bounty/slash_attack.xml", x, y)
            EntityAddChild(entity, child)
        end,
    },
}

function AddBountyAttack(entity, x, y, index)
    local attack
    if type(index) == "number" then
        attack = bounty_attacks[index]
    elseif type(index) == "string" then
        for i=1,#bounty_attacks do
            if bounty_attacks[i].id == index then
                attack = bounty_attacks[i]
                break
            end
        end
    elseif type(index) == "table" then
        for i=1,#index do
            AddBountyAttack(entity, x, y, index[i])
        end
    end
    if attack ~= nil then
        attack.func_init(entity, x, y)
        EntityAddComponent2(entity, "SpriteParticleEmitterComponent", {
            _tags="ff_shard",
            sprite_file=attack.shard_sprite or "mods/foolish_flame/files/entities/misc/bounty/shard_sprites/flares.png",
            sprite_centered=true,
            count_min=1,
            count_max=1,
            emission_interval_min_frames=1,
	        emission_interval_max_frames=1,
        })
        return attack.id
    end
end

function BountyAttacks(entity, x, y, attack_count)
    for i=1,attack_count do
        SetRandomSeed(x, y + i)
        local num = Random(1, #bounty_attacks)
        AddBountyAttack(entity, x, y, num)
    end
end