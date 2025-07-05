function onEvent(eventName, value1, value2)
    if eventName == "Dad Lyric" then
        if value2 == "" or value2 == nil then value2 = 1; end
        doTweenAlpha("lyricTxt", "lyricTxt", 1, (stepCrochet / 500) / playbackRate)
        --doTweenAlpha("lyricTxt", "lyricTxt", 1, 0.05)
        if getCharLyricName(dadName) ~= nil then setProperty("lyricTxt.text", getCharLyricName(dadName)..":\n"..string.gsub(value1, "/n", "\n")) else setProperty("lyricTxt.text", string.gsub(value1, "/n", "\n")) end
        if shadersEnabled then runHaxeCode([[game.getLuaObject("lyricTxt").shader = getVar("distortFNFLyrics");]]) end
        runHaxeCode([[game.getLuaObject("lyricTxt").color = FlxColor.BLACK;]])
        if dadName == "cumball" then 
            if shadersEnabled then removeSpriteShader("lyricTxt") end
        end
        if dadName == "cumball" or dadName == "FINNPHASE1" then runHaxeCode([[game.getLuaObject("lyricTxt").color = FlxColor.WHITE;]]) end
        if dadName == "gumball" then runHaxeCode([[game.getLuaObject("lyricTxt").color = FlxColor.fromRGB(game.dad.healthColorArray[0],game.dad.healthColorArray[1],game.dad.healthColorArray[2]);]]) end
        runTimer("dialouge fade", tonumber(value2) / playbackRate)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "dialouge fade" then
        doTweenAlpha("lyricTxt", "lyricTxt", 0, (stepCrochet / 500) / playbackRate)
        --doTweenAlpha("lyricTxt", "lyricTxt", 0, 0.05)
    end
end
