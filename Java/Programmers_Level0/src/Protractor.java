
public class Protractor {
	public static int solution(int angle) {
		if (angle <= 0 && angle > 180) {
			System.out.println("0 ~ 180 사이의 값이 아닙니다.");
			return 0;
		}
		
		int answer = 0;
		
		if (angle < 90)
			answer = 1;
		else if (angle == 90)
			answer = 2;
		else if (angle < 180)
			answer = 3;
		else
			answer = 4;
		
		return answer;			
	}
	
	public static void main(String[] args) {
		System.out.println(solution(70));
		System.out.println(solution(91));
		System.out.println(solution(180));
	}
}
