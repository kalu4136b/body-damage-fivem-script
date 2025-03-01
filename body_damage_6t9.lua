-- bodypart_damage.lua

-- Define body part bone IDs
local bodyParts = {
    HEAD = 31086,
    NECK = 39317,
    UPPER_BODY = 24818,
    LOWER_BODY = 11816,
    LEFT_ARM = 45509,
    RIGHT_ARM = 40269,
    LEFT_LEG = 58271,
    RIGHT_LEG = 51826
}

-- Define additional damage multipliers for body parts
local damageMultipliers = {
    [bodyParts.HEAD] = 2.0, -- head (2x damage)
    [bodyParts.NECK] = 1.0, -- neck
    [bodyParts.UPPER_BODY] = 1.5, -- chest
    [bodyParts.LOWER_BODY] = 1.0, -- lower body
    [bodyParts.LEFT_ARM] = 0.7, -- left arm
    [bodyParts.RIGHT_ARM] = 0.7, -- right arm
    [bodyParts.LEFT_LEG] = 0.5, -- left leg
    [bodyParts.RIGHT_LEG] = 0.5 -- right leg
}

-- Event handler for when a player is damaged
AddEventHandler('gameEventTriggered', function(eventName, eventData)
    if eventName == 'CEventNetworkEntityDamage' then
        local victim = eventData[1]
        local attacker = eventData[2]
        local weaponHash = eventData[5]
        local isFatal = eventData[6]

        -- Ensure the victim is a player and the attacker exists
        if IsEntityAPed(victim) and IsPedAPlayer(victim) and attacker ~= nil then
            local boneIndex = GetPedLastDamageBone(victim)
            local damageMultiplier = damageMultipliers[boneIndex] or 1.0

            -- Apply additional damage based on the body part
            local baseDamage = 10 -- Example base damage
            local damage = baseDamage * damageMultiplier
            SetEntityHealth(victim, GetEntityHealth(victim) - damage)

            -- Debug output (optional)
            print(string.format("Player hit in body part: %d, Damage multiplier: %.2f, Damage dealt: %.2f", boneIndex, damageMultiplier, damage))
        end
    end
end)