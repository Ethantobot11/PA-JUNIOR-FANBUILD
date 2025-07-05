//WARNING READ THIS!!
//WARNING READ THIS!!

//
//THIS IS CODE FROM PIBBY APOCALYPSE, PORTED TO PSYCH ENGINE BY JUNIORNOVOA (YXERX)
//

//WARNING READ THIS!!
//WARNING READ THIS!!
import flixel.sound.FlxSound;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.Lib;
import Std;
import flixel.tweens.misc.NumTween;
import sys.io.Process;
import flixel.system.FlxShader;
import sys.FileSystem;
import sys.io.File;

import psychlua.LuaUtils;
import psychlua.DebugLuaText;
import psychlua.ModchartSprite;

var crtFNF:FlxRuntimeShader;
//var mawFNF:FlxRuntimeShader;//Shaders.MAWVHS;
var ntscFNF:FlxRuntimeShader;//Shaders.NtscShader;
var distortFNF:FlxRuntimeShader;
var distortFNFLyrics:FlxRuntimeShader;
var distortCAWMFNF:FlxRuntimeShader;
var distortDadFNF:FlxRuntimeShader;
var invertFNF:FlxRuntimeShader;//Shaders.InvertShader;
var glowfnf:FlxRuntimeShader;
var pibbyFNF:FlxRuntimeShader;//Shaders.Pibbified;
var chromFNF:FlxRuntimeShader;
var pincFNF:FlxRuntimeShader;//Shaders.PincushionShader;
var blurFNF:FlxRuntimeShader;//Shaders.BlurShader;
//var blurFNFZoomEdition:FlxRuntimeShader;
//var blurFNFZoomEditionHUD:FlxRuntimeShader;
//var glitchFWFNF:FlxRuntimeShader; // here's where i follow scissor's concept n stuff
var bloomFNF:FlxRuntimeShader;

var strumShaders:Array<FlxRuntimeShader> = [];

//stage shaders
var greyscale:FlxRuntimeShader;
var coolShader:FlxRuntimeShader;
var pixel:FlxRuntimeShader;
var thatOtherPixel:FlxRuntimeShader;

function boundTo(value:Float, min:Float, max:Float):Float {
	return Math.max(min, Math.min(max, value));
}

var defaultOpponentStrum:Array<{x:Float, y:Float}> = [];
var defaultPlayerStrum:Array<{x:Float, y:Float}> = [];

createGlobalCallback('setStrumShaders', function(){
	if (!ClientPrefs.data.shaders) return;
	for (i in 0...game.opponentStrums.length) 
		game.opponentStrums.members[i].shader = strumShaders[i];
});
createGlobalCallback('setCustomShaderInt', function(shader:String, varName:String, value:Int){
	getVar(shader).setInt(varName, value);
});
createGlobalCallback('setCustomShaderFloat', function(shader:String, varName:String, value:Float){
	getVar(shader).setFloat(varName, value);
});
createGlobalCallback('setCameraShaders', function(camera:String, shaders:Array<String>) {
	var shaderArray:Array<ShaderFilter> = [];
	for (i in 0...shaders.length) {
		shaderArray.push(new ShaderFilter(getVar(shaders[i])));
	}
	switch(camera) {
		case "other":
			game.camOther.setFilters(shaderArray);
		case "hud":
			game.camHUD.setFilters(shaderArray);
		case "game":
			game.camGame.setFilters(shaderArray);
		default:
			game.camGame.setFilters(shaderArray);
	}
});
createGlobalCallback('clearCameraShaders', function(camera:String) {
	switch(camera) {
		case "other":
			game.camOther.setFilters([]);
		case "hud":
			game.camHUD.setFilters([]);
		case "game":
			game.camHUD.setFilters([]);
		default:
			game.camGame.setFilters([]);
	}
});

function onCountdownStarted()
{
	game.strumLineNotes.forEachAlive(function(strum)
	{
		strum.useRGBShader = false;
	});
	for (daNote in game.unspawnNotes)
		daNote.rgbShader.enabled = false;

	for (i in 0...game.playerStrums.length) {
		defaultPlayerStrum.push({x: game.playerStrums.members[i].x, y: game.playerStrums.members[i].y});
	}
	for (i in 0...game.opponentStrums.length) {
		defaultOpponentStrum.push({x: game.opponentStrums.members[i].x, y: game.opponentStrums.members[i].y});

		if (ClientPrefs.data.shaders){
			if (PlayState.SONG.song == "Mindless v2") 
				strumShaders.push(new FlxRuntimeShader(File.getContent(Paths.shaderFragment("distortOld")), null, 100));
			else
				strumShaders.push(new FlxRuntimeShader(File.getContent(Paths.shaderFragment("distort")), null, 100));
			strumShaders[i].setFloat("negativity", 0.0);
        	strumShaders[i].setFloat("binaryIntensity", 1000.0);
			game.opponentStrums.members[i].shader = strumShaders[i];
		}
		//if(ClientPrefs.middleScroll) opponentStrums.members[i].visible = false;
	}
}

var camVoid:FlxCamera;
function onCreate():Void
{
	if (ClientPrefs.data.shaders){
		pibbyFNF = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("Pibbified")), null, 100);
	//	ntscFNF = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("NtscShader")), null, 100);
	//	mawFNF = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("MAWVHS")), null, 100);
		crtFNF = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("monitor")), null, 100);
		distortFNF = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("distort")), null, 100);
		distortFNFLyrics = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("distort")), null, 100);
        distortCAWMFNF = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("distort")), null, 100);
        glowfnf = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("glowy")), null, 100);
		distortDadFNF = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("distort")), null, 100);
	//	invertFNF = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("InvertShader")), null, 100);
		chromFNF = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("chromShader")), null, 100);
		pincFNF = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("PincushionShader")), null, 100);
		blurFNF = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("BlurShader")), null, 100);
	//	blurFNFZoomEdition = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("BlurZoom")), null, 100);
	//	blurFNFZoomEditionHUD = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("BlurZoom")), null, 100);
	//	glitchFWFNF = if (!ClientPrefs.data.lowQuality) new FlxRuntimeShader(File.getContent(Paths.shaderFragment("fwGlitch")), null, 100); else new FlxRuntimeShader(File.getContent(Paths.shaderFragment("fwGlitchtrash")), null, 100);
		bloomFNF = if (!ClientPrefs.data.lowQuality) new FlxRuntimeShader(File.getContent(Paths.shaderFragment("dayybloomshadertrash")), null, 100) else new FlxRuntimeShader(File.getContent(Paths.shaderFragment("dayybloomshadertrash")), null, 100);
		
		
		/*FlxG.cameras.bgColor = FlxColor.TRANSPARENT;
		camVoid = new FlxCamera();
		FlxG.cameras.add(camVoid, false);
		camVoid.setFilters([new ShaderFilter(pincFNF)]);*/

		pibbyFNF.setInt("NUM_SAMPLES", 3.0);
		pibbyFNF.setFloat("iMouseX", 500);

        distortDadFNF.setFloat("negativity", 0.0);
        distortFNF.setFloat("negativity", 0.0);
		distortFNFLyrics.setFloat("negativity", 0.0);
        distortCAWMFNF.setFloat("negativity", 0.0);

        distortFNF.setFloat("binaryIntensity", 1000.0);
		distortFNFLyrics.setFloat("binaryIntensity", 1000.0);
        distortCAWMFNF.setFloat("binaryIntensity", 1000.0);

		//stage shaders
		if (PlayState.curStage == "school" && incompatibleShaders) 
			greyscale = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("Greyscale")), null, 100);
		else if (PlayState.curStage == "school" && !incompatibleShaders)
			greyscale = distortFNF; //fallback.

		if (!incompatibleShaders)
			blurFNF = distortFNF; //fallback.
		
		if (PlayState.curStage == "voidFW" || PlayState.curStage == "treehouse" || PlayState.curStage == "50th Dead World") {
			coolShader = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("file")), null, 120);

			pixel = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("pixel")), null, 120);
			pixel.setFloat('size', 10);
		
			thatOtherPixel = new FlxRuntimeShader(File.getContent(Paths.shaderFragment("pixel")), null, 120);
			thatOtherPixel.setFloat('size', 5);
		}
    }
 
	if(ClientPrefs.data.shaders) {
		game.camHUD.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
		game.camGame.setFilters([new ShaderFilter(pibbyFNF),new ShaderFilter(chromFNF)]);
	}
	if(ClientPrefs.data.shaders) {
		chromFNF.setFloat('aberration', -0.5);
	}

	if(ClientPrefs.data.shaders) {
		setVar("pibbyFNF", pibbyFNF);
		setVar("ntscFNF", ntscFNF);
		//setVar("mawFNF", mawFNF);
		setVar("crtFNF", crtFNF);
		setVar("distortFNF", distortFNF);
		setVar("distortFNFLyrics", distortFNFLyrics);
		setVar("distortCAWMFNF", distortCAWMFNF);
		setVar("glowfnf", glowfnf);
		setVar("distortDadFNF", distortDadFNF);
		setVar("invertFNF", invertFNF);
		setVar("chromFNF", chromFNF);
		setVar("pincFNF", pincFNF);
		setVar("blurFNF", blurFNF);
		//setVar("blurFNFZoomEdition", blurFNFZoomEdition);
		//setVar("blurFNFZoomEditionHUD", blurFNFZoomEditionHUD);
		//setVar("glitchFWFNF", glitchFWFNF);
		setVar("bloomFNF", bloomFNF);
		//if (PlayState.SONG.song == "main-menu" && incompatibleShaders) setVar("VCR", new FlxRuntimeShader(File.getContent(Paths.shaderFragment("OldTVShader")), null, 100));

		if (greyscale != null) setVar("greyscale", greyscale);
		if (coolShader != null) setVar("coolShader", coolShader);
		if (pixel != null) setVar("pixel", pixel);
		if (thatOtherPixel != null) setVar("thatOtherPixel", thatOtherPixel);
		//if (mindlessShaderEffect != null) setVar("mindlessShaderEffect", mindlessShaderEffect);
	}
}

// vv in place of FlxTimer because that shid SUCKS!!
var distortShaderTimes:Array<Float> = [0,0];
var strumShaderTimes:Array<Float> = [0,0,0,0];

var beatShaderAmount:Float = 0.05;
var glitchShaderIntensity:Float;
var distortIntensity:Float;
var distortIntensityLyrics:Float;
var dadGlitchIntensity:Float;
var abberationShaderIntensity:Float;
var blurIntensity:Float;

var shaderStuff:Float = 0;
function onUpdate(elapsed:Float)
{
	if(ClientPrefs.data.shaders) {
		shaderStuff += elapsed;

		if (game.healthBar.percent < 20) {
			game.iconP1.shader = distortFNF;
			if (game.gf != null) {
				//game.getLuaObject("iconP3").shader = distortFNF;
				game.getLuaObject("iconPibby").shader = distortFNF;
			}
		} else if (game.boyfriend.curCharacter != "darwinfw") {
			game.iconP1.shader = null;
			if (game.gf != null && game.getLuaObject("iconPibby") != null) {
				//game.getLuaObject("iconP3").shader = null;
				game.getLuaObject("iconPibby").shader = null;
			}
		}

		if (game.healthBar.percent > 80 && game.dad.curCharacter != "cumball" && game.dad.curCharacter != "cumball_2") {
			game.iconP2.shader = distortFNF;
			if (game.getLuaObject("iconJake") != null) game.getLuaObject("iconJake").shader = distortFNF;
		} else {
			game.iconP2.shader = null;
			if (game.getLuaObject("iconJake") != null) game.getLuaObject("iconJake").shader = null;
		}

		chromFNF.setFloat('aberration', abberationShaderIntensity); // error in this shader/line
		pibbyFNF.setFloat('glitchMultiply', glitchShaderIntensity);
		distortFNF.setFloat('binaryIntensity', distortIntensity);
		distortFNFLyrics.setFloat("binaryIntensity", distortIntensityLyrics);
		for (i in 0...strumShaders.length) {
			if (PlayState.SONG.song == "Mindless v2") 
				strumShaders[i].setFloat('iTime', shaderStuff + i);				
			strumShaders[i].setFloat('binaryIntensity', distortIntensity);
			if (strumShaderTimes[i] > 0) {
				strumShaderTimes[i] -= elapsed;
			} else {		
				strumShaderTimes[i] = 0.0;
				strumShaders[i].setFloat('negativity', 0.0);
			}
		}
		if (getVar("VCR") != null) getVar("VCR").setFloat("iTime", shaderStuff);
		distortCAWMFNF.setFloat('binaryIntensity', distortIntensity);
		distortDadFNF.setFloat('binaryIntensity', dadGlitchIntensity);
		pibbyFNF.setFloat('uTime', shaderStuff);
	//	mawFNF.setFloat('iTime', shaderStuff);
		if (incompatibleShaders) {
			blurFNF.setFloat('amount', blurIntensity);
			blurFNF.setFloat('iTime', shaderStuff);
		}
	//	glitchFWFNF.setFloat('iTime', shaderStuff);
		if (coolShader != null) 
			coolShader.setFloat('iTime', shaderStuff);

		var shaders = [distortDadFNF, distortCAWMFNF]; // maybe put this somewhere else as like a "distortShaders" array? esp since its used multiple times in the code
		// its fine rn tho so w/e
		for(idx in 0...distortShaderTimes.length){
			distortShaderTimes[idx] -= elapsed;
			if(distortShaderTimes[idx] < 0)distortShaderTimes[idx] = 0;
			if(distortShaderTimes[idx] == 0){
				shaders[idx].setFloat("negativity", 0.0);
				if(idx == 0){
					if(game.dad.shader == shaders[idx])game.dad.shader = null;
					//if(jake != null && jake.shader == shaders[idx])jake.shader = null;
				}
			}
		}
	}
	glitchShaderIntensity = FlxMath.lerp(glitchShaderIntensity, 0, boundTo(elapsed * 7, 0, 1));
	abberationShaderIntensity = FlxMath.lerp(abberationShaderIntensity, 0, boundTo(elapsed * 6, 0, 1));
}

function goodNoteHit(note:Note) 
{
	if (!note.isSustainNote && game.boyfriend.curCharacter == "darwinfw") 
		glitchShaderIntensity += FlxG.random.float(0.1, 0.35);
	/*else if (note.isSustainNote && game.boyfriend.curCharacter != "darwinfw") 
		glitchShaderIntensity = 0;*/
	
	var glitching = false;
	if (note.noteType == 'Glitch Note' || note.noteType == 'Both Char Glitch') {
		glitching = true;
        if(!note.isSustainNote){
			for (i in 0...game.playerStrums.length) {
				game.playerStrums.members[i].x = defaultPlayerStrum[i].x + FlxG.random.int(-8, 8);
				game.playerStrums.members[i].y = defaultPlayerStrum[i].y + FlxG.random.int(-8, 8);
			}
			if (note.noteType == 'Both Char Glitch') {
	            for (i in 0...game.playerStrums.length) {
					game.opponentStrums.members[i].x = defaultOpponentStrum[i].x + FlxG.random.int(-8, 8);
					game.opponentStrums.members[i].y = defaultOpponentStrum[i].y + FlxG.random.int(-8, 8);
				}
			}
		}
	}
}

function opponentNoteHit(note:Note)
{
    var glitching = false;
	if (note.noteType == "Glitch Miss Note" && ClientPrefs.data.shaders) {
		glitching = true;
		//strumShaders[note.noteData].setFloat("negativity", 1.0);
		//strumShaderTimes[note.noteData] = (note.sustainLength > 0 ? note.sustainLength/1000 : 0) + FlxG.random.float(0.0475, 0.085);

		dadGlitchIntensity = FlxG.random.float(-1, -0.5);
        // if(game.dad.shader == null && game.dad.curCharacter == "cumball_2") game.dad.shader = distortCAWMFNF;
	    distortCAWMFNF.setFloat("negativity", 1.0);
		strumShaderTimes[note.noteData] = (note.sustainLength > 0 ? note.sustainLength/1000 : 0) + FlxG.random.float(0.0475, 0.085) + 0.25;
		distortShaderTimes[1] = (note.sustainLength > 0 ? note.sustainLength/1000 : 0) + FlxG.random.float(0.0475, 0.085) + 0.25;
	}
	if (note.noteType == 'Glitch Note' || note.noteType == 'Both Char Glitch') {
        glitching = true;
        if(!note.isSustainNote){
            for (i in 0...game.opponentStrums.length) {
                game.opponentStrums.members[i].x = defaultOpponentStrum[i].x + FlxG.random.int(-8, 8);
                game.opponentStrums.members[i].y = defaultOpponentStrum[i].y + FlxG.random.int(-8, 8);
            }
			if (note.noteType == 'Both Char Glitch') {
	            for (i in 0...game.playerStrums.length) {
					game.playerStrums.members[i].x = defaultPlayerStrum[i].x + FlxG.random.int(-8, 8);
					game.playerStrums.members[i].y = defaultPlayerStrum[i].y + FlxG.random.int(-8, 8);
				}
			}
           // boyfriendColor = FlxColor.fromRGB(boyfri}.healthColorArray[0], boyfri}.healthColorArray[1], boyfri}.healthColorArray[2]); //WHAT THE FUCK
            if (ClientPrefs.data.shaders)
            {
				strumShaders[note.noteData].setFloat("negativity", 1000);
				strumShaderTimes[note.noteData] = (note.sustainLength > 0 ? note.sustainLength/1000 : 0) + FlxG.random.float(0.0475, 0.085);

                dadGlitchIntensity = FlxG.random.float(-1, -0.5);
                var shaders = [distortDadFNF, distortCAWMFNF];
                if(game.dad.shader == null)game.dad.shader = distortDadFNF;
                for(idx in 0...shaders.length){
                    var shader = shaders[idx];
                    shader.setFloat("negativity", 1.0);
                    distortShaderTimes[idx] = (note.sustainLength > 0 ? note.sustainLength/1000 : 0) + FlxG.random.float(0.0475, 0.085);
                }
            }
        }
	} else if (FlxG.random.int(1, 4) == 1 && !note.isSustainNote && game.dad.curCharacter != "cumball" && note.noteType != "Glitch Miss Note" && note.noteType != "GF Sing" && !note.gfNote && ClientPrefs.data.shaders) {
		strumShaders[note.noteData].setFloat("negativity", 1000);
		strumShaderTimes[note.noteData] = FlxG.random.float(0.0475, 0.085);
	}
	if(!glitching){
		for(idx in 0...distortShaderTimes.length)
			distortShaderTimes[idx] = 0; // remove the glitching
		/*for (i in 0...strumShaders.length)
			strumShaders[i].setFloat('negativity', 0.0);*/
	}
	if (!note.gfNote && game.dad.curCharacter != "cumball") {
		if (!note.isSustainNote) {
			/*game.health -= FlxG.random.float(0.075, 0.2);

    		if (FlxG.random.float(0, 1) < 0.5) {
            	game.camGame.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.075, 0.125));
        	} else{
            	game.camHUD.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.075, 0.125));
        	    for (i in 0...opponentStrums.length) {
					game.opponentStrums.members[i].x = defaultOpponentStrum[i].x + FlxG.random.int(-8, 8);
					game.opponentStrums.members[i].y = defaultOpponentStrum[i].y + FlxG.random.int(-8, 8);					
           		}
        	}*/

			if (FlxG.random.int(0, 1) == 0) {
				glitchShaderIntensity = FlxG.random.float(0.2, 0.7);
			}
		}
	}
}
function onStepHit()
{	
	if (ClientPrefs.data.shaders) {
		distortIntensity = FlxG.random.float(4, 6);
		distortIntensityLyrics = FlxG.random.float(8, 12);
	}
}
function onBeatHit()
{
	if (ClientPrefs.data.shaders) {
		if (pixel != null) 
			pixel.setFloat('size', FlxG.random.int(5, 15));
		if (thatOtherPixel != null) 
			thatOtherPixel.setFloat('size', FlxG.random.int(2, 7));
	}
}

function onSectionHit()
{
	if (camZooming && FlxG.camera.zoom < 1.35 && ClientPrefs.data.camZooms)
		abberationShaderIntensity = beatShaderAmount;
}

function onEvent(name:String, value1:String, value2:String, strumTime:Float)
{
	if (name == "Set Distortion Amount")
        distortIntensity = Std.parseFloat(value1); //distortFNF.setFloat("negativity", Std.parseFloat(value2));
	if (name == "Set Glitch Amount")
		glitchShaderIntensity = Std.parseFloat(value1);
	if (name == "Set Chromatic Amount")
		abberationShaderIntensity = Std.parseFloat(value1);
	if (name == "Add Camera Zoom")
		abberationShaderIntensity = beatShaderAmount;
	if (name == "Set Blur Amount")
		blurIntensity = Std.parseFloat(value1);
}