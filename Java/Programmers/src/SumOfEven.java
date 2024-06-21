import java.util.Arrays;
import java.util.stream.IntStream;

public class SumOfEven {
	public static int solution(int n) {
		IntStream intArr = IntStream.rangeClosed(1, n);
		
		return intArr.filter(num -> num%2==0).sum();
	}
	
	public static void main(String[] args) {
		System.out.println(solution(10));
		System.out.println(solution(4));
	}
}
