import java.util.Arrays;

public class SubArray {
	public static int[] solution1(int[] numbers, int num1, int num2) {
		return Arrays.copyOfRange(numbers, num1, num2+1);
	}
	
	public static int[] solution2(int[] numbers, int num1, int num2) {
		int[] answer = new int[num2 - num1 + 1];
		
		for (int i=num1, j=0; i<num2+1; i++, j++)
			answer[j] = numbers[i];
		return answer;
	}

	public static void main(String[] args) {
		int[] numbers1 = {1, 2, 3, 4, 5};
		System.out.println(Arrays.toString(solution1(numbers1, 1, 3)));
		System.out.println(Arrays.toString(solution2(numbers1, 1, 3)));

		int[] numbers2 = {1, 3, 5};
		System.out.println(Arrays.toString(solution1(numbers2, 1, 2)));
		System.out.println(Arrays.toString(solution2(numbers2, 1, 2)));
	}
}
