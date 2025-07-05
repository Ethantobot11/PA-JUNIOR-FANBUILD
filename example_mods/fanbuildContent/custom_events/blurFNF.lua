function onCreate()
    initLuaShader("BlurShader")
    makeLuaSprite("BlurShader")
    setSpriteShader("BlurShader", "BlurShader")
end

local elapsedTotal = 0.0;
function onUpdate(elapsed)
    elapsedTotal = elapsedTotal + elapsed;
    setShaderFloat("BlurShader", "iTime", elapsedTotal)
end

function onEvent(eventName, value1, value2)
    if eventName == "blurFNF" then
        setShaderFloat("BlurShader", "amount", tonumber(value2))
        if string.lower(value1) == 'on' then
            runHaxeCode([[game.camGame.setFilters([new ShaderFilter(game.getLuaObject("BlurShader").shader)]);]])
        else
            runHaxeCode([[game.camGame.setFilters([]);]])
        end
    end
end