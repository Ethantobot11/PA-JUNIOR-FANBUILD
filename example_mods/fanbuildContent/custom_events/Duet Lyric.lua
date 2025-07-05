function onEvent(eventName, value1, value2)
    if eventName == "Duet Lyric" then
        if value2 == "" or value2 == nil then value2 = 1; end
        doTweenAlpha("lyricTxt", "lyricTxt", 1, (stepCrochet / 500) / playbackRate)
        local dialogueTxt = string.gsub(value1, "/n", "\n");
        if getCharLyricName(boyfriendName) ~= nil and getCharLyricName(dadName) ~= nil then
            setProperty("lyricTxt.text", getCharLyricName(dadName).." & "..getCharLyricName(boyfriendName)..":\n"..dialogueTxt)
        else 
            setProperty("lyricTxt.text", dialogueTxt)
        end
        if shadersEnabled then removeSpriteShader("lyricTxt") end
        runHaxeCode([[game.getLuaObject("lyricTxt").color = FlxColor.WHITE;]])
        runTimer("dialouge fade", tonumber(value2) / playbackRate)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == "dialouge fade" then
        doTweenAlpha("lyricTxt", "lyricTxt", 0, (stepCrochet / 500) / playbackRate)
    end
end
