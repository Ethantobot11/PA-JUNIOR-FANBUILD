//WARNING READ THIS!!
//WARNING READ THIS!!

//
//THIS CODE IS BY JUNIORNOVOA (YXERX)
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
import objects.Character;
import lime.app.Application;
import lime.graphics.Image;

import backend.CoolUtil;
import objects.Note;

import psychlua.LuaUtils;
import psychlua.DebugLuaText;
import psychlua.ModchartSprite;

var charLyricNameMapPrefix:String = "charLyricName.";
var charDescPrefix:String = "charDesc.";

var charLyricNames:Dynamic = game.variables;
var realPath:String;
var skin:String = null;
function onCreatePost():Void
{
	if(PlayState.SONG != null && PlayState.SONG.arrowSkin != null && PlayState.SONG.arrowSkin.length > 1) skin = PlayState.SONG.arrowSkin;
	else skin = Note.defaultNoteSkin;
	realPath = skin;
	if (skin == "noteSkins/NOTE_assets_dark") {
		for (i in 0...4) {
			Note.globalRgbShaders[i].r = ClientPrefs.data.arrowRGB[0][0]; Note.globalRgbShaders[i].g = ClientPrefs.data.arrowRGB[0][1]; Note.globalRgbShaders[i].b = ClientPrefs.data.arrowRGB[0][2];
		}
	} else {
		for (i in 0...4) {
			Note.globalRgbShaders[i].r = ClientPrefs.data.arrowRGB[i][0]; Note.globalRgbShaders[i].g = ClientPrefs.data.arrowRGB[i][1]; Note.globalRgbShaders[i].b = ClientPrefs.data.arrowRGB[i][2];
		}
	}
}
function onSpawnNote(note) {
	if ((note.texture != realPath && note.texture != "") || (note.texture == "" && (skin != realPath))) {
		//trace("CHANGING SKIN FROM (" + note.texture + ") TO (" + realPath + ")");
		note.texture = realPath;
	}
}
function onCreate():Void
{
	createGlobalCallback('setStrumsSkin', function(skin){
		if (skin == "NOTE_assets_dark") {
			for (i in 0...4) {
				Note.globalRgbShaders[i].r = ClientPrefs.data.arrowRGB[0][0]; Note.globalRgbShaders[i].g = ClientPrefs.data.arrowRGB[0][1]; Note.globalRgbShaders[i].b = ClientPrefs.data.arrowRGB[0][2];
			}
		} else {
			for (i in 0...4) {
				Note.globalRgbShaders[i].r = ClientPrefs.data.arrowRGB[i][0]; Note.globalRgbShaders[i].g = ClientPrefs.data.arrowRGB[i][1]; Note.globalRgbShaders[i].b = ClientPrefs.data.arrowRGB[i][2];
			}
		}
		realPath = "noteSkins/" + skin;
		for (i in 0...game.strumLineNotes.length) 
			game.strumLineNotes.members[i].texture = realPath;
	
		game.notes.forEachAlive(function(note) { note.texture = realPath; });
		//for (note in unspawnNotes) note.texture = realPath;
	});

	charLyricNames.set(charLyricNameMapPrefix + "Steven_Corrupted", "STEVEN");

	var beefingBfs = ["newbf", "mindless_newbf", "cleannewbf", "cleannewbf_teaser", "cleannewbf_test_gun", "bfcawn", "bf-swords"]; 
	for (i in 0...beefingBfs.length) charLyricNames.set(charLyricNameMapPrefix + beefingBfs[i], "Boyfriend");
	
	var pibbyingPibs = ["pibby", "pibby_angy", "pibby-r"]; 
	for (i in 0...pibbyingPibs.length) charLyricNames.set(charLyricNameMapPrefix + pibbyingPibs[i], "Pibby");
	
	var darwinism = ["darwin", "darwinretcon", "darwin-noremote", "darwinfw"]; 
	for (i in 0...darwinism.length) charLyricNames.set(charLyricNameMapPrefix + darwinism[i], "Darwin");

	var feinfinns = ["FINNPHASE1", "FINNPHASE2", "FINNANIM", "FINNOLD", "finn-sword", "finn-sword-sha", "finn-slash", "finn-hurting", "finncawm_start_new", "finncawm_reveal", "finnanimstuff", "finncawn"];
	for (i in 0...feinfinns.length) charLyricNames.set(charLyricNameMapPrefix + feinfinns[i], "FINN");
	charLyricNames.set(charLyricNameMapPrefix + "jake", "JAKE");

	var gumBalls = ["cumball", "cumball_2", "gumball"];
	for (i in 0...gumBalls.length) charLyricNames.set(charLyricNameMapPrefix + gumBalls[i], "GUMBALL");

	game.variables.set(charDescPrefix + "cumball", "A Happy Soul");
	game.variables.set(charDescPrefix + "cumball_2", "A Lost Soul");
	game.variables.set(charDescPrefix + "gumball", "A Fallen Soul");

	game.variables.set(charDescPrefix + "FINNPHASE1", "The Man in The Shadows");
	var feinfinns = ["FINNPHASE2", "FINNANIM", "FINNOLD", "finn-sword", "finn-sword-sha", "finn-slash", "finn-hurting"];
	for (i in 0...feinfinns.length) game.variables.set(charDescPrefix + feinfinns[i], "A Fallen Hero");

	game.variables.set(charDescPrefix + "finncawm_start_new", "A Peaceful Soul");
	game.variables.set(charDescPrefix + "finnanimstuff", "A Peaceful Soul..?");
	game.variables.set(charDescPrefix + "finncawm_reveal", "A Corrupted Soul");
	game.variables.set(charDescPrefix + "finncawn", "A Lost Soul");

	createGlobalCallback('getCharLyricName', function(tag:String){
		if (charLyricNames.exists(charLyricNameMapPrefix + tag)) return charLyricNames.get(charLyricNameMapPrefix + tag);
		return null;
	});
	createGlobalCallback('getBFcam', function(){
		if (songName == "Come Along With Me") {
			return [1710, 2305]; } 
		return [game.boyfriend.getMidpoint().x - 100 - game.boyfriend.cameraPosition[0] + game.boyfriendCameraOffset[0], (game.boyfriend.getMidpoint().y - 100) + game.boyfriend.cameraPosition[1] + game.boyfriendCameraOffset[1]];
	});
	createGlobalCallback('getDADcam', function(){
		if (songName == "Come Along With Me") {
			return [1710, 2305]; }
		if ((game.dad.curCharacter == "finn-slash" || game.dad.curCharacter == "finn-hurting") && game.dadMap.exists("finn-sword"))
			return [game.dadMap.get("finn-sword").getMidpoint().x + 150 + game.dadMap.get("finn-sword").cameraPosition[0] - game.opponentCameraOffset[0], (game.dadMap.get("finn-sword").getMidpoint().y - 100) + game.dadMap.get("finn-sword").cameraPosition[1] + game.opponentCameraOffset[1]];
		return [game.dad.getMidpoint().x + 150 + game.dad.cameraPosition[0] - game.opponentCameraOffset[0], (game.dad.getMidpoint().y - 100) + game.dad.cameraPosition[1] + game.opponentCameraOffset[1]];
	});
	createGlobalCallback('getGFcam', function(){
		if (PlayState.SONG.song == "Mindless v2")
			return [game.boyfriend.getMidpoint().x - 100 - game.boyfriend.cameraPosition[0] + game.boyfriendCameraOffset[0], (game.boyfriend.getMidpoint().y - 100) + game.boyfriend.cameraPosition[1] + game.boyfriendCameraOffset[1]]; 
		return [game.gf.getMidpoint().x + game.gf.cameraPosition[0] + game.girlfriendCameraOffset[0], game.gf.getMidpoint().y + game.gf.cameraPosition[1] + game.girlfriendCameraOffset[1]];
	});
	createGlobalCallback('forceCamZoom', function(zoom:Float){
		game.camGame.zoom = zoom;
		game.defaultCamZoom = zoom;
	});
	createGlobalCallback('setWindowTitle', function(title:String, ?prefix:Bool = true){
		if (prefix == null) prefix = true;
		if (prefix)
			Application.current.window.title = "Pibby: Apocalypse - "+title+" - (Junior's" + (debugBuild ? " Private" : "") + " PA Fanbuild v" + fanbuildVersion + ")";
		else
			Application.current.window.title = title;
	});
	createGlobalCallback('setWindowIcon', function(icon:String){
		// Lib.application.window.setIcon(Image.fromFile(Paths.modsImages('windowIcon/' + icon)));
	});
	createGlobalCallback('destroyCharacter', function(name:String, type:String){
		var char = game.getLuaObject(name);
		char.kill();
		char.destroy();

		switch (type)
		{
			case "dad":
				game.dadGroup.remove(char);
			case "gf":
				game.gfGroup.remove(char);
			case "bf":
				game.boyfriendGroup.remove(char);
		}
		game.modchartSprites.set(name, null);
	});
	createGlobalCallback('createCharacter', function(name:String, type:String, character:String, isPlayer:Bool){
		var char = new Character(0, 0, character, isPlayer);
		game.startCharacterPos(char, false);
		switch (type)
		{
			case "dad":
				//char.setPosition(game.dad.x, game.dad.y);
				game.dadGroup.add(char);
				game.addBehindDad(char);
			case "gf":
				//char.setPosition(game.gf.x, game.gf.y);
				game.gfGroup.add(char);
				game.addBehindGF(char);
			case "bf":
				//char.setPosition(game.boyfriend.x, game.boyfriend.y);
				game.boyfriendGroup.add(char);
				game.addBehindBF(char);
		}
		game.modchartSprites.set(name, char);
	});
	/*createGlobalCallback('setObjectBitmapDataFromChar', function(obj:String, char:String){
		var gameChar:Character;
		switch (char)
		{
			case "dad":
				gameChar = game.dad;
			case "gf":
				gameChar = game.gf;
			case "bf":
				gameChar = game.boyfriend;
			case "boyfriend":
				gameChar = game.boyfriend;
		}
		if (gameChar != null) {
	
			//game.getLuaObject(obj).pixels = gameChar.pixels;
			var obj = game.getLuaObject(obj);//game.boyfriend;

			obj.pixels = gameChar.pixels.clone();
			obj.frame = gameChar.frame;
			//obj.x = gameChar.x - gameChar.offset.x;
			//obj.y = gameChar.y - gameChar.offset.y;
			//obj.offset.set(gameChar.animOffsets.get(gameChar.getAnimationName())[0], gameChar.animOffsets.get(gameChar.getAnimationName())[1]);
			obj.scale.set(gameChar.jsonScale, gameChar.jsonScale);
			obj.updateHitbox();
		}
		return;
	});	*/
	createGlobalCallback('getFlxColor', function(col:String){
		return FlxColor.fromString(col);
	});
	createGlobalCallback('colorFromString', function(col:String){
		return CoolUtil.colorFromString(col);
	});
	createGlobalCallback('doTweenCameraZoom', function(tag:String, value:Float, duration:Float, ease:String, ?forceCamera:Bool = false) {
		PlayState.instance.modchartTweens.set(tag, FlxTween.num(game.defaultCamZoom, value, duration, {ease: LuaUtils.getTweenEaseByString(ease),
			onUpdate: function(twn:FlxTween) {
				if (forceCamera) game.camGame.zoom = twn.value;
				game.defaultCamZoom = twn.value;
			}, onComplete: function(twn:FlxTween) {
				PlayState.instance.modchartTweens.remove(tag);
				PlayState.instance.callOnLuas('onTweenCompleted', [tag]);
			}
		}));
    });

	// honestly this should be part of the chart file but whatever
	createGlobalCallback('getSongName', function(song:String) //song should be in uppercase, like the songName var
	{
		if (song == "Mindless")
			return song;
		
		return CoolUtil.getFakeSongName(song);
	});
	createGlobalCallback('getSongInfo', function(song:String) //song should be in uppercase, like the songName var
	{
		return CoolUtil.getSongDesc(song);
	});
	createGlobalCallback('getSongArtist', function(song:String) //song should be in uppercase, like the songName var
	{
		return CoolUtil.getSongArtist(song);
	});
	
	createGlobalCallback("doTweenXDelay", function(tag:String, vars:String, value:Dynamic, duration:Float, ease:String, delay:Float) {
		var target:Dynamic = LuaUtils.tweenPrepare(tag, vars);
		if(target != null) {
			PlayState.instance.modchartTweens.set(tag, FlxTween.tween(target, {x: value}, duration, {ease: LuaUtils.getTweenEaseByString(ease), startDelay: delay,
				onComplete: function(twn:FlxTween) {
					PlayState.instance.modchartTweens.remove(tag);
					PlayState.instance.callOnLuas('onTweenCompleted', [tag, vars]);
				}
			}));
		}
	});
	createGlobalCallback("doTweenYDelay", function(tag:String, vars:String, value:Dynamic, duration:Float, ease:String, delay:Float) {
		var target:Dynamic = LuaUtils.tweenPrepare(tag, vars);
		if(target != null) {
			PlayState.instance.modchartTweens.set(tag, FlxTween.tween(target, {y: value}, duration, {ease: LuaUtils.getTweenEaseByString(ease), startDelay: delay,
				onComplete: function(twn:FlxTween) {
					PlayState.instance.modchartTweens.remove(tag);
					PlayState.instance.callOnLuas('onTweenCompleted', [tag, vars]);
				}
			}));
		}
	});
	createGlobalCallback("doTweenAlphaDelay", function(tag:String, vars:String, value:Dynamic, duration:Float, ease:String, delay:Float) {
		var target:Dynamic = LuaUtils.tweenPrepare(tag, vars);
		if(target != null) {
			PlayState.instance.modchartTweens.set(tag, FlxTween.tween(target, {alpha: value}, duration, {ease: LuaUtils.getTweenEaseByString(ease), startDelay: delay,
				onComplete: function(twn:FlxTween) {
					PlayState.instance.modchartTweens.remove(tag);
					PlayState.instance.callOnLuas('onTweenCompleted', [tag, vars]);
				}
			}));
		}
	});
	createGlobalCallback("cameraShakeTween", function(tag:String, camera:String, oldintensity:Float, newintensity:Float, duration:Float, ease:String) {
		PlayState.instance.modchartTweens.set(tag, FlxTween.num(oldintensity, newintensity, duration, {ease: LuaUtils.getTweenEaseByString(ease),
			onUpdate: function(twn:FlxTween) {
				LuaUtils.cameraFromString(camera).shake(twn.value, 0.001);
			}, onComplete: function(twn:FlxTween) {
				PlayState.instance.modchartTweens.remove(tag);
				PlayState.instance.callOnLuas('onTweenCompleted', [tag]);
			}
		}));
	});
	
}