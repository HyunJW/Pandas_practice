
public class AddToHiddenNum {
	public static int solution1(String my_string) {
		int answer = 0;
//		for (int i=0; i<my_string.length(); i++) {
//			if ('0' < my_string.charAt(i) && my_string.charAt(i) <= '9')
//				answer += my_string.charAt(i) - '0';
//		}
		for (char c: my_string.toCharArray()) {
			if ('0' < c && c <= '9')
				answer += c - '0';
		}
		return answer;
	}
	
	public static int solution2(String my_string) {
		return my_string.chars()
				.mapToObj(i -> (char)i)
				.filter(Character::isDigit)
				.map(String::valueOf)
				.mapToInt(Integer::valueOf).sum();
	}
	
	public static int solution3(String my_string) {
		int answer = 0;
		for (char c: my_string.toCharArray()) {
			if (Character.isDigit(c))
//				answer += Integer.parseInt(String.valueOf(c));
				answer += Character.getNumericValue(c);
		}
		return answer;
	}
	
	public static void main(String[] args) {
		System.out.println(solution1("aAb1B2cC34oOp"));
		System.out.println(solution1("1a2b3c4d123"));
		System.out.println();
		System.out.println(solution2("aAb1B2cC34oOp"));
		System.out.println(solution2("1a2b3c4d123"));
		System.out.println();
		System.out.println(solution3("aAb1B2cC34oOp"));
		System.out.println(solution3("1a2b3c4d123"));
	}
}
