import java.util.Arrays;

public class DuplicatedNumber {
	public static int solution(int[] array, int n) {
		return (int)Arrays.stream(array).filter(num -> num==n).count();
	}
	
	public static void main(String[] args) {
		int[] intArr1 = {1, 1, 2, 3, 4, 5};
		int[] intArr2 = {0, 2, 3, 4};
		System.out.println(solution(intArr1, 1));
		System.out.println(solution(intArr2, 1));
	}
}
