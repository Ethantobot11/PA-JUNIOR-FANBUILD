function onEvent(eventName, value1, value2)
    if eventName == "BF Lyric" then
        if value2 == "" or value2 == nil then value2 = 1; end
        doTweenAlpha("lyricTxt", "lyricTxt", 1, (stepCrochet / 500) / playbackRate)
        if getCharLyricName(boyfriendName) ~= nil then setProperty("lyricTxt.text", getCharLyricName(boyfriendName)..":\n"..string.gsub(value1, "/n", "\n")) else setProperty("lyricTxt.text", string.gsub(value1, "/n", "\n")) end
        if shadersEnabled then removeSpriteShader("lyricTxt") end
        runHaxeCode([[game.getLuaObject("lyricTxt").color = FlxColor.WHITE;]])
        if boyfriendName == "gumball" then runHaxeCode([[game.getLuaObject("lyricTxt").color = FlxColor.fromRGB(game.boyfriend.healthColorArray[0],game.boyfriend.healthColorArray[1],game.boyfriend.healthColorArray[2]);]]) end
        runTimer("dialouge fade", tonumber(value2) / playbackRate)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "dialouge fade" then
        doTweenAlpha("lyricTxt", "lyricTxt", 0, (stepCrochet / 500) / playbackRate)
    end
end
