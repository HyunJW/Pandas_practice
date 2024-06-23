import java.util.Arrays;

public class MultipleOfN {
	public static int[] solution(int n, int[] numlist) {
		return Arrays.stream(numlist).filter(i -> i%n==0).toArray();
	}
	
	public static void main(String[] args) {
		int[] numlist1 = {4, 5, 6, 7, 8, 9, 10, 11, 12};
		int n1 = 3;
		System.out.println(Arrays.toString(solution(n1, numlist1)));
		
		int[] numlist2 = {1, 9, 3, 10, 13, 5};
		int n2 = 5;
		System.out.println(Arrays.toString(solution(n2, numlist2)));
		
		int[] numlist3 = {2, 100, 120, 600, 12, 12};
		int n3 = 12;
		System.out.println(Arrays.toString(solution(n3, numlist3)));
	}
}
