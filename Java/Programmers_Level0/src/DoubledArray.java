import java.util.Arrays;

public class DoubledArray {
	public static int[] solution(int[] numbers) {
		return Arrays.stream(numbers).map(i -> i*2).toArray();
	}
	
	public static void main(String[] args) {
		int[] numbers1 = {1, 2, 3, 4, 5};
		int[] numbers2 = {1, 2, 100, -99, 1, 2, 3};
		
		System.out.println(Arrays.toString(solution(numbers1)));
		System.out.println(Arrays.toString(solution(numbers2)));
	}
}
