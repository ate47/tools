package fr.atesab.randomcolor;

import java.awt.Color;

public class RandomColor {
	public static final float TETA = (float)(2*Math.PI*500F);
  
	/**
	 * clamp an integer between a max and a minimum value
	 * @param i the integer to clamp
	 * @param min minimum value
	 * @param max maximum value
	 * @return the clamped value
	 */
	public static int clamp_int(int i, int min, int max) {
		return i<min?min:i>max?max:i;
	}
  
	/**
	 * Get a random color with the current system time
	 * @param shift the percentage of TETA to shift
	 * @return the color
	 */
	public static Color getRandomColorByTime(float shift) {
		float f = (float)(System.currentTimeMillis()%((long)TETA))/500F+shift*TETA/500F;
		return new Color(
				clamp_int((int)(Math.sin(f)*200F), 0, 200)+55, 
				clamp_int((int)(Math.sin(f+(float)(2F/3F*Math.PI))*200F), 0, 200)+55, 
				clamp_int((int)(Math.sin(f+(float)(4F/3F*Math.PI))*200F), 0, 200)+55);
	}
}
