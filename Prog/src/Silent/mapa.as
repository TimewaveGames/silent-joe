package Silent
{
	/**
	 * ...
	 * @author Max Benin
	 */
	
	import org.flixel.*;
	 
	public class mapa extends FlxTilemap
	{
		[Embed(source = '../../../Art/Release/Tiles/TileSet.png')] public var ImgTiles:Class;
		[Embed(source = '../../../Design/Release/levels/stage1.txt', mimeType = "application/octet-stream")] public var DataMap:Class;
		[Embed(source = '../../../Design/Release/levels/stage2.txt', mimeType = "application/octet-stream")] public var DataMap2:Class;
		[Embed(source = '../../../Design/Release/levels/stage3.txt', mimeType = "application/octet-stream")] public var DataMap3:Class;
		[Embed(source = '../../../Design/Release/levels/stage4.txt', mimeType = "application/octet-stream")] public var DataMap4:Class;
		[Embed(source = '../../../Design/Release/levels/stage5.txt', mimeType = "application/octet-stream")] public var DataMap5:Class;
		[Embed(source = '../../../Design/Release/levels/stage6.txt', mimeType = "application/octet-stream")] public var DataMap6:Class;
		[Embed(source = '../../../Design/Release/levels/stage7.txt', mimeType = "application/octet-stream")] public var DataMap7:Class;
		[Embed(source = '../../../Design/Release/levels/stage8.txt', mimeType = "application/octet-stream")] public var DataMap8:Class;
		[Embed(source = '../../../Design/Release/levels/stage9.txt', mimeType = "application/octet-stream")] public var DataMap9:Class;
		
		private var mapArrays:Array = [new DataMap, new DataMap2, new DataMap3, new DataMap4, new DataMap5, new DataMap6, new DataMap7, new DataMap8, new DataMap9];
		
		private var array:Array = new Array();
		
		public function mapa(n:uint) 
		{
			this.auto = this.auto;
			this.loadMap(mapArrays[n], ImgTiles,32,32);
			this.drawIndex 		= 1;
			this.collideIndex	= 30;
			this.fixed = true;
			
		}
	}

}