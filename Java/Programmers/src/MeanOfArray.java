import java.util.Arrays;

public class MeanOfArray {
	public static double solution1(int[] intArr) {
		int sum = 0;
		double result = 0;
		
		for (int i=0; i<intArr.length; i++) {
			sum += intArr[i];
		}
		
		result = sum / (double)intArr.length;
		return result;
	}
	
	public static double solution2(int[] intArr) {
		int sum = 0;
		double result = 0;
		
		for (int i: intArr) {
			sum += i;
		}
		
		result = sum / (double)intArr.length;
		return result;
	}
	
	public static double solution3(int[] intArr) {
		return Arrays.stream(intArr).average().orElse(0);
	}
	
	public static void main(String[] args) {
		int[] intArr = Arrays.asList(args)
							.stream()
							.mapToInt(Integer::parseInt)
							.toArray();
		System.out.println(Arrays.toString(intArr));
		System.out.println(solution1(intArr));
		System.out.println(solution2(intArr));
		System.out.println(solution3(intArr));
	}
}
