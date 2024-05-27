
public class Ex3_14 {

	public static void main(String[] args) {
		String str1 = "abc";
		String str2 = new String("abc");
		
		System.out.printf("\"abc\"==\"abc\" ? %b%n", "abc"=="abc");
		System.out.printf("str1==\"abc\" ? %b%n", str1=="abc");
		System.out.printf("str2==\"abc\" ? %b%n", str2=="abc");
		System.out.printf("str1.equal(\"abc\") ? %b%n", str1.equals("abc"));
		System.out.printf("str2.equal(\"abc\") ? %b%n", str2.equals("abc"));
		System.out.printf("str2.equal(\"ABC\") ? %b%n", str2.equals("ABC"));
		System.out.printf("str2.equalsIgnoreCase(\"ABC\") ? %b%n", 
				str2.equalsIgnoreCase("ABC")); // equalsIgnoreCase(): 대소문자 구별없이 비교
	}
}
