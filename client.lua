local config = {
    ['antiControllerAimAssist'] = true
    ['antiLockon'] = true
}

CreateThread(function()
    if not config['antiControllerAimAssist'] then return end
    while true do
        if NetworkGetTargetingMode() ~= 3 then
            SetPlayerTargetingMode(3)
        else
            wait(1000)
        end 
        wait(200)
    end
end)

CreateThread(function()
    if not config['antiLockon'] then return end
    while true do
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)
        SetPedConfigFlag(ped, 43, true)
        if weapon ~= 0 and weapon ~= 'WEAPON_UNARMED' then
            local lockOn = GetLockonDistanceOfCurrentPed(ped)
            if lockOn > 500.0 then
                local player = PlayerId()
                SetPlayerLockon(player, false) 
                SetPlayerLockonRangeOverride(player, -1.0)
            end
        end
        wait(2500)
    end

end)