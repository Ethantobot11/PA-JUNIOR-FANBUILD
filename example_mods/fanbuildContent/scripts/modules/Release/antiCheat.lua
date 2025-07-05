function youCheatedRah()
	setProperty("inCutscene", true)

	if getVar("videos") then 
		runHaxeCode([[
			game.persistentUpdate = false;
			game.camOther.fade(0x000000, 3 / game.playbackRate, true);

			var video:VideoSprite;
			video = new VideoSprite(Paths.video("Cheating_is_a_sin"), false, false, false);
			video.finishCallback = function(){
				game.persistentUpdate = true;
				if (buildTarget == "windows")
					Application.current.window.alert('Our game, our rules, ' + Sys.getEnv("USERNAME") + '.' + '\n- Finn');
				else
					Application.current.window.alert('Our game, our rules, ' + Sys.getEnv("USER") + '.' + '\n- Finn');
				Sys.exit(0);
				return;
			};
			video.camera = game.luaTpadCam;
			game.add(video);
			video.play();
			setVar("cheatingVid", video);
		]])
	else
		runHaxeCode([[
			if (buildTarget == "windows")
				Application.current.window.alert('Our game, our rules, ' + Sys.getEnv("USERNAME") + '.' + '\n- Finn');
			else
				Application.current.window.alert('Our game, our rules, ' + Sys.getEnv("USER") + '.' + '\n- Finn');
			Sys.exit(0);
		]])
	end
end

function onUpdate(elapsed)
	setProperty("allowDebugKeys", debugBuild)
	if (keyJustPressed('debug_1') or keyJustPressed('debug_2')) and not debugBuild then
		setProperty("canPause", false)

		setProperty("cpuControlled", true) -- not letting you die
		runHaxeCode([[FlxTween.tween(FlxG.sound.music, {pitch: 0.001}, 6, {onComplete: e -> FlxG.sound.music.stop()});]])
		doTweenZoom("gameDEBUG", "camGame", getPropertyFromClass("flixel.FlxG", "camera.zoom") + 0.6, 6)
		doTweenAlpha("hudDEBUG", "camHUD", 0.001, 6)
		runHaxeCode([[FlxTween.tween(game.vocals, {pitch: 0.001}, 6, {onComplete: e -> game.vocals.stop()});]])
		runHaxeCode([[game.vocals.fadeOut(6.5);]])
		runHaxeCode([[
			FlxTween.num(game.playbackRate, 0.001, 6, {onUpdate: function(twn:FlxTween) {
				game.playbackRate = twn.value; }
			});
			FlxTween.num(game.songSpeed, 0.001, 6, {onUpdate: function(twn:FlxTween) {
				game.songSpeed = twn.value; }
			});
		]])

		runHaxeCode([[FlxG.sound.music.fadeOut(6.5);]])
		cameraFade("game", "000000", 6)
		runTimer("cameraFinishFadefsd", 6)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "cameraFinishFadefsd" then
		runTimer("youCheatedRah", 2)
		runHaxeCode([[FlxG.sound.music.stop();]])
	end
	if tag == "youCheatedRah" then
		youCheatedRah()
	end
end