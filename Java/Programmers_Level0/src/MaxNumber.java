import java.util.*;
import java.util.stream.*;

public class MaxNumber {
	public static int[] solution(int[] array) {
		List<Integer> intList = Arrays.stream(array).boxed().collect(Collectors.toList());
		int max = intList.stream().max(Integer::compareTo).orElse(0);
		int index = intList.indexOf(max);
		return new int[] {max, index};
	}
	
	public static void main(String[] args) {
		int[] array1 = {1, 8, 3};
		System.out.println(Arrays.toString(solution(array1)));
		
		int[] array2 = {9, 10, 11, 8};
		System.out.println(Arrays.toString(solution(array2)));
	}
}
