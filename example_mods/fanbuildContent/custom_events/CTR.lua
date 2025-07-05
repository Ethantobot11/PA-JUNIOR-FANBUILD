function onCreate()
    initLuaShader("monitor")
    makeLuaSprite("monitor")
    setSpriteShader("monitor", "monitor")
end

function onEvent(eventName, value1, value2)
    if eventName == "CTR" then
        if string.lower(value1) == 'on' then
            runHaxeCode([[game.camGame.setFilters([new ShaderFilter(game.getLuaObject("monitor").shader)]);]])
            runHaxeCode([[game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("monitor").shader)]);]])
        else
            runHaxeCode([[game.camGame.setFilters([]);]])
            runHaxeCode([[game.camHUD.setFilters([]);]])
        end
    end
end