import java.util.Arrays;

public class IceAmericano {
	public static int[] solution(int money) {
		int price = 5500;
		int[] answer = new int[2];
		
		answer[0] = money / price;
		answer[1] = money % price;
		return answer;
//		return new int[] {(int)(money/5500), money%5500}; 
	}
	
	public static void main(String[] args) {
		System.out.println(Arrays.toString(solution(5500)));
		System.out.println(Arrays.toString(solution(15000)));
	}
}
