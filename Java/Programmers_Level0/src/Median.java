import java.util.Arrays;

public class Median {
	public static int solution(int[] array) {
		Arrays.sort(array);
		return array[array.length/2];
	}
	
	public static void main(String[] args) {
		int[] array1 = {1, 2, 7, 10, 11};
		int[] array2 = {9, -1, 0};
		
		System.out.println(solution(array1));
		System.out.println(solution(array2));
	}
}
