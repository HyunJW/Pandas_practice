
public class Ex3_9 {

	public static void main(String[] args) {
		int a = 1_000_000;
		int b = 2_000_000;
		
		long c = a * b; // a * b 의 값이 int값이므로 long형 변수에 넣어도 변하지 않음
		
		System.out.println(c);
		
		c = a * (long)b; // a, b 중 하나를 long으로 형변환 후 연산해야 올바른 결과가 나옴
		
		System.out.println(c);
	}
}
