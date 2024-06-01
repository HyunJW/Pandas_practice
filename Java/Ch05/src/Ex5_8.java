
public class Ex5_8 {

	public static void main(String[] args) {
		int[][] score = {
				{70, 62, 88},
				{55, 43, 25},
				{30, 35, 33},
				{20, 40, 42}
		};
		int sum = 0;
		
		for (int i=0; i<score.length; i++) {
			for (int j=0; j<score[i].length; j++) {
				System.out.printf("score[%d][%d]= %d%n", i, j, score[i][j]);
				sum += score[i][j];
			}
		}
		System.out.println("sum= " + sum);
	}
}
