package fr.atesab.spiral;

public class SpiralCreator {
	public static int[] getSpiralPosition(int n) {
		n++;
		int i;
		for (i = 1; n > i*i; i+=2);
		int ln = n-(i-2)*(i-2);
		if (ln > i*2)
			return new int[] {-i/2+((ln-1)%2)*(i-1),-i/2+1+((ln-i*2-1)/2)};
		else
			return new int[] {-i/2+(ln-1)%i,-i/2+(i-1)*((ln-1)/i)};
	}
  /*
   * try the function, will return : 
   * 26 40 42 44 46 48 33
   * 27 10 20 22 24 15 34
   * 28 11 02 08 05 16 35
   * 29 12 03 01 06 17 36
   * 30 13 04 09 07 18 37
   * 31 14 21 23 25 19 38
   * 32 41 43 45 47 00 39
   */
	public static void main(String[] args) {
		int[][] matrix = new int[7][7];
		for (int i = 0; i < 48; i++) {
			int[] p = getSpiralPosition(i);
			matrix[p[0]+3][p[1]+3] = i+1;
		}
		String s = "";
		for (int i = 0; i < matrix.length; i++) {
			for (int j = 0; j < matrix[i].length; j++) {
				s+=" "+(matrix[i][j]<10 ? "0" : "") + String.valueOf(matrix[i][j]);
			}
			s+="\n";
		}
		System.out.println(s);
	}
}
