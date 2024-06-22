import java.util.stream.*;
import java.util.Arrays;

public class OddArray {
	public static int[] solution(int n) {
		return IntStream.rangeClosed(1, n).filter(i -> i%2!=0).toArray();
	}
	
	public static void main(String[] args) {
		System.out.println(Arrays.toString(solution(10)));
		System.out.println(Arrays.toString(solution(15)));
	}
}
