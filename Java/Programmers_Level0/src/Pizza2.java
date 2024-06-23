
public class Pizza2 {
	public static int solution(int slice, int n) {
		return (int)((n+slice-1)/slice);
	}
	
	public static void main(String[] args) {
		System.out.println(solution(7, 10));
		System.out.println(solution(4, 12));
	}
}
