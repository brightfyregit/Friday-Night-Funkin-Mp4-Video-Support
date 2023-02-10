package hxcodec._internal;

#if (!(desktop || android) && macro)
#error 'LibVLC only supports the Windows, Mac, Linux, and Android target platforms.'
#end

/**
 * @see https://videolan.videolan.me/vlc/group__libvlc__media__discoverer.html
 */
@:buildXml("<include name='${haxelib:hxcodec}/project/Build.xml' />") // Link static/dynamic libraries for VLC
@:include('vlc/vlc.h') // Include VLC functions and types
@:keep // Fix issues with DCE
@:unreflective // TODO: Write down why this is needed
extern class LibVLCMediaDiscovery {}
