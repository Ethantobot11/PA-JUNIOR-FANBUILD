function onEvent(eventName, value1, value2)
    if eventName == "Cinematics" then
        local val2 = tonumber(value2);
        if string.lower(value1) == 'on' then
            doTweenY("cinematicup", "cinematicup", -260, val2 / playbackRate, "cubeOut")
            doTweenY("cinematicdown", "cinematicdown", screenHeight - 100, val2 / playbackRate, "cubeOut")
        else
            doTweenY("cinematicup", "cinematicup", -360, val2 / playbackRate, "cubeOut")
            doTweenY("cinematicdown", "cinematicdown", screenHeight , val2 / playbackRate, "cubeOut")
        end
    end
end