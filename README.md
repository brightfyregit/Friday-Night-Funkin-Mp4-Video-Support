# hxCodec - Native video support for OpenFL & HaxeFlixel
[Original Repository](https://github.com/polybiusproxy/PolyEngine).  
[Click here to check the roadmap of hxCodec](https://github.com/brightfyregit/Friday-Night-Funkin-Mp4-Video-Support/projects/1).

## Table of Contents
- [Instructions](#instructions)  
- [Building](#building)  
- [Credits](#credits)  

## Instructions
**These are for Friday Night Funkin' mostly so it may not work for your HaxeFlixel project.**

### 1. Install the Haxelib:
[Install the Haxelib here](https://lib.haxe.org/p/hxCodec/).
You can also install it through git:
```cmd
haxelib git hxCodec https://github.com/polybiusproxy/hxCodec.git
```

### 2. Create a folder called `videos` in your `assets/preload` folder

### 3. add this code in `Project.xml`
```xml
<haxelib name="hxcodec"/>
```

**OPTIONAL: If your PC is ARM64, add this code in `Project.xml`:**
```xml
<haxedef name="HXCPP_ARM64" />
```

**OPTIONAL: If you want debug traces in your console, add this code in `Project.xml`:**
```xml
<!--Show debug traces for hxCodec-->
<haxedef name="HXC_DEBUG_TRACE" if="debug" />
```

### 4. Edit `Paths.hx`
```haxe
inline static public function video(key:String)
{
	return 'assets/videos/$key';
}
```

### 5. Playing videos
1. Put your video in the videos folder
2. Create somewhere in PlayState:
```haxe
import vlc.VideoHandler;

var video:VideoHandler;

function playCutscene(name:String) //supported video formats for VLC can be used
{
	inCutscene = true;

	video = new VideoHandler();
	video.finishCallback = function()
	{
		startCountdown();
	}
	video.playVideo(Paths.video(name));
}

function playEndCutscene(name:String) //supported video formats for VLC can be used
{
	inCutscene = true;

	video = new VideoHandler();
	video.finishCallback = function()
	{
		SONG = Song.loadFromJson(storyPlaylist[0].toLowerCase());
		FlxG.switchState(new PlayState());
	}
	video.playVideo(Paths.video(name));
}
```

**supported formats:**
ASF, AVI, MP4, MJPEG, OGG, WAV.

### EXAMPLE (FOR FNF)
At the PlayState "create()" function:
```haxe
switch (curSong.toLowerCase())
{
	case 'song1':
		playCutscene('song1scene.asf');
	case 'song2':
		playCutscene('song2scene.avi');
	default:
		startCountdown();
}
```
**FOR KADE 1.8 USERS!!**
```haxe
generateSong(SONG.songId);

switch (curSong.toLowerCase())
{
	case 'song3':
		playCutscene('song3scene.mp4');
	default:
		startCountdown();
}

```

At the PlayState "endSong()" function:
```haxe
if (SONG.song.toLowerCase() == 'song4')
	playEndCutscene('song4scene.mjpeg');
```

**FOR KADE 1.8 USERS**
```haxe
PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0], diff);
FlxG.sound.music.stop();

switch (curSong.toLowerCase())
{
	case 'song5':
		playEndCutscene('song5scene.ogg');
	case 'song6':
		playEndCutscene('song6scene.wav');
}
```

## BUILDING
### Windows
You don't need any special instructions in order to build for Windows.
Just pull the `lime build windows`.

### Linux
In order to make your game work with the library, every Linux user (this includes the player) **has to download** "libvlc-dev" and "libvlccore-dev" from your distro's package manager.
You can also install them through the terminal:
```bash
sudo apt-get install libvlc-dev
sudo apt-get install libvlccore-dev
```

### Android
Currently, hxCodec will search the videos only on the external storage (`/storage/emulated/0/appname/assets/videos/yourvideo.(extension)`), one more thing, you need to put the location manualy in paths.
This is not suitable for games and will be fixed soon.

## Credits
- [PolybiusProxy](https://github.com/polybiusproxy) - Creator of hxCodec.
- [datee](https://github.com/datee) - Creator of HaxeVLC.
- [Jigsaw](https://github.com/jigsaw-4277821) - Android Support
- [Erizur](https://github.com/Erizur) - Linux Support
- The contributors.
