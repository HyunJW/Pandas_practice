import java.util.stream.*;

public class SwapCase {
	public static String solution1(String my_string) {
		String answer = "";
		for (char c: my_string.toCharArray()) {
			if (Character.isUpperCase(c))
				answer += Character.toLowerCase(c);
			else if (Character.isLowerCase(c))
				answer += Character.toUpperCase(c);
			else
				answer += c;
		}
		return answer;
	}
	
	public static String solution2(String my_string) {
		String answer = "";
		for (int i=0; i<my_string.length(); i++) {
			char c = my_string.charAt(i);
			
			if ('a'<=c && c<='z')
				c -= 32;
			else if ('A'<=c && c<='Z')
				c += 32;
			
			answer += c;
		}	
		return answer;
	}
	
	public static String solution3(String my_string) {
		return my_string.chars()
				.mapToObj(c -> 
					String.valueOf((char)(Character.isLowerCase(c) ? 
							Character.toUpperCase(c): Character.toLowerCase(c)))
					)
				.collect(Collectors.joining());
	}
	
	public static void main(String[] args) {
		String my_string = "cccCCC";
		System.out.println(solution1(my_string));
		System.out.println(solution2(my_string));
		System.out.println(solution3(my_string));
		
		my_string = "abCdEfghIJ";
		System.out.println(solution1(my_string));
		System.out.println(solution2(my_string));
		System.out.println(solution3(my_string));
	}
}
