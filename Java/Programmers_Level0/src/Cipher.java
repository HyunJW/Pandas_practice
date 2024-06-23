
public class Cipher {
	public static String solution(String cipher, int code) {
		String answer = "";
		for (int i=code-1; i<cipher.length(); i+=code) {
			answer += cipher.substring(i, i+1);
		}
		
		return answer;
	}
	
	public static void main(String[] args) {
		String cipher = "dfjardstddetckdaccccdegk";
		int code = 4;
		System.out.println(solution(cipher, code));
		
		cipher = "pfqallllabwaoclk";
		code = 2;
		System.out.println(solution(cipher, code));
	}
}
