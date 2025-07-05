function onEvent(eventName, value1, value2)
    if eventName == "Tween Cam Zoom" then
        doTweenCameraZoom("tweenZoom"..value1, tonumber(value1), tonumber(value2) / playbackRate, "sineInOut", true)
    end
end