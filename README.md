# hxCodec - Native video support for OpenFL & Flixel

[Original Repository](https://github.com/polybiusproxy/PolyEngine).

[Click here to check the roadmap of hxCodec here](https://github.com/brightfyregit/Friday-Night-Funkin-Mp4-Video-Support/projects/1)

## Credits

- [PolybiusProxy (me!)](https://github.com/polybiusproxy) - Creator of hxCodec.
- [datee](https://github.com/datee) - Creator of HaxeVLC.
- [BrightFyre](https://github.com/brightfyregit) - Creator of repository.
- [GWebDev](https://github.com/GrowtopiaFli) - Inspiring me to do this.
- [CryBit](https://github.com/CryBitDev) - fixing my shit lolololoolol
- The contributors.

## Instructions
**These are for Friday Night Funkin mostly so it may not work for your flixel project.**

### 1. Download the repository:
You can either download it as a ZIP,
or git cloning it.

### 2. Edit `Project.xml`
Above
```xml
<assets path="assets/preload" rename="assets" exclude="*.ogg" if="web"/>
```
Add
```xml
<assets path="assets/preload/videos" rename="assets/videos" include="*mp4" embed='false' />

<assets path="plugins/" rename='' if="cpp" />
<assets path="dlls/" rename='' if="cpp" />
```

### 3. Edit `Paths.hx`
```haxe
inline static public function video(key:String, ?library:String)
{
	return getPath('videos/$key.mp4', BINARY, library);
}
```

### 4. Edit `Main.hx`
1. Set zoom to 1 instead of -1.
2. Remove this code
```haxe
var stageWidth:Int = Lib.current.stage.stageWidth;
var stageHeight:Int = Lib.current.stage.stageHeight;

if (zoom == -1)
{
	var ratioX:Float = stageWidth / gameWidth;
	var ratioY:Float = stageHeight / gameHeight;
	zoom = Math.min(ratioX, ratioY);
	gameWidth = Math.ceil(stageWidth / zoom);
	gameHeight = Math.ceil(stageHeight / zoom);
}
```

### 5. Playing videos

1. Put your video in `assets/preload/videos`.
2. Create somewhere in PlayState
```haxe
var video:MP4Handler;

function playCutscene(name:String)
{
	inCutscene = true;

	video = new MP4Handler(Paths.video(name));
	video.finishCallback = function()
	{
		startCountdown();
		startIntro.playAnim();
		cameraMovement();
	}
}

function playEndCutscene(name:String)
{
	inCutscene = true;

	video = new MP4Handler(Paths.video(name));
	video.finishCallback = function()
	{
		SONG = Song.loadFromJson(storyPlaylist[0].toLowerCase());
		LoadingState.loadAndSwitchState(new PlayState());
	}
}
```

3. In the onFocus function
```haxe
video.resumeVideo();
```

4. In the onFocusLost function
```haxe
video.pauseVideo();
```

### 6. Example
At PlayState create function
```haxe
switch (curSong.toLowerCase())
{
	case 'too-slow':
		playCutscene('tooslowcutscene1');
	case 'you-cant-run':
		playCutscene('tooslowcutscene2');
	default:
		startCountdown();
}
```

At PlayState endSong function
```haxe
if (SONG.song.toLowerCase() == 'triple-trouble')
	playEndCutscene('soundtestcodes');
```