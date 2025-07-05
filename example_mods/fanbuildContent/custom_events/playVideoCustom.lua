function onEvent(eventName, value1, value2)
    if eventName == "playVideoCustom" then
        startVideo(value1, true, false, false, true)
        setProperty("inCutscene", false)
        setProperty("canPause", true)
    end
end