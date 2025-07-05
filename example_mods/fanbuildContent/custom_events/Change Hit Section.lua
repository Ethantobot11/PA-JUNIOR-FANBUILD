function onEvent(eventName, value1, value2)
    if eventName == "Change Hit Section" then
        runHaxeCode([[
            game.setOnLuas('mustHitSection', ]]..value1..[[);
            game.setOnHScript('mustHitSection', ]]..value1..[[);
        ]])
    end
end