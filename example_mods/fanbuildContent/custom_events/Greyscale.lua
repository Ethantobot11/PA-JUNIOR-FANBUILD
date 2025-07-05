function onCreate()
    initLuaShader("Greyscale")
    makeLuaSprite("Greyscale")
    setSpriteShader("Greyscale", "Greyscale")
end

function onEvent(eventName, value1, value2)
    if eventName == "Greyscale" then
        if string.lower(value1) == 'on' then
            runHaxeCode([[game.camGame.setFilters([new ShaderFilter(game.getLuaObject("Greyscale").shader)]);]])
        else
            runHaxeCode([[game.camGame.setFilters([]);]])
        end
    end
end