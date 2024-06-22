import java.util.Arrays;

public class TallerPerson {
	public static int solution(int[] array, int height) {
		return (int)Arrays.stream(array).filter(i -> i > height).count();
	}
	
	public static void main(String[] args) {
		int[] intArr1 = {149, 180, 192, 170};
		int height1 = 167;
		System.out.println(solution(intArr1, height1));
		
		int[] intArr2 = {180, 120, 140};
		int height2 = 190;
		System.out.println(solution(intArr2, height2));
	}
}
