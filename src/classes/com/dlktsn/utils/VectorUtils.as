package com.dlktsn.utils {

	/**
	 * @author valck
	 */
	public class VectorUtils {
		private static function vectorToArray(p_vector:*):Array{
			var n:int = p_vector.length; var a:Array = new Array();
			for(var i:int = 0; i < n; i++) a[i] = p_vector[i];
			return a;
		}

		public static function sortOn(p_vector:*, p_field:Object, p_options:Object  = null) : Array{
			return vectorToArray(p_vector).sortOn(p_field, p_options);
		}
	}
}