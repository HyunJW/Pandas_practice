
public class Pizza {
	public static int solution(int n) {
		return (n + 6) / 7;
	}
	
	public static void main(String[] args) {
		System.out.println(solution(7));
		System.out.println(solution(1));
		System.out.println(solution(15));
	}
}
