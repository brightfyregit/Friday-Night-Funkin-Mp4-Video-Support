package hxcodec.openfl;

import openfl.Lib;
import openfl.display.Sprite;
import hxcodec.openfl.VideoBitmap;
import lime.app.Event;
import sys.FileSystem;

/**
 * This class allows you to play videos using sprites (Sprite).
 */
class VideoSprite extends Sprite
{
	// Variables
	public var bitmap(default, null):VideoBitmap;
	public var autoResize:Bool = true;
	public var maintainAspectRatio:Bool = true;

	public function new():Void
	{
		super();

		bitmap = new VideoBitmap();
		addChild(bitmap);
	}

	// Methods
	public function play(?Path:String, Loop:Bool = false):Int
	{
		if (bitmap == null)
			return -1;

		// in case if you want to use another dir then the application one.
		// android can already do this, it can't use application's storage.
		if (FileSystem.exists(Sys.getCwd() + Path))
			return bitmap.play(Sys.getCwd() + Path, Loop);
		else
			return bitmap.play(Path, Loop);
	}

	public function stop():Void
	{
		if (bitmap != null)
			bitmap.stop();
	}

	public function pause():Void
	{
		if (bitmap != null)
			bitmap.pause();
	}

	public function resume():Void
	{
		if (bitmap != null)
			bitmap.resume();
	}

	public function togglePaused():Void
	{
		if (bitmap != null)
			bitmap.togglePaused();
	}

	public function dispose():Void
	{
		if (bitmap == null)
			return;

		bitmap.dispose();

		if (contains(bitmap))
			removeChild(bitmap);
	}

	// Overrides
	@:noCompletion private override function __enterFrame(deltaTime:Int):Void
	{
		for (child in __children)
			child.__enterFrame(deltaTime);

		if (autoResize && (bitmap != null && bitmap.bitmapData != null && contains(bitmap)))
		{
			var aspectRatio:Float = bitmap.videoWidth / bitmap.videoHeight;

			if (Lib.current.stage.stageWidth / Lib.current.stage.stageHeight > aspectRatio)
			{
				// stage is wider than video
				bitmap.width = Lib.current.stage.stageHeight * aspectRatio;
				bitmap.height = Lib.current.stage.stageHeight;
			}
			else
			{
				// stage is taller than video
				bitmap.width = Lib.current.stage.stageWidth;
				bitmap.height = Lib.current.stage.stageWidth * (1 / aspectRatio);
			}
		}
	}
}
