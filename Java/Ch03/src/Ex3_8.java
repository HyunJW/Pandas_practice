
public class Ex3_8 {

	public static void main(String[] args) {
		byte a = 10, b = 30;
		byte c = (byte)(a*b);
		System.out.println(c);
		
		/*
		 * 컴파일 에러 발생
		 * byte c = a + b; -> 300은 byte형의 범위를 넘기 때문에 byte형으로 형변환 필요 
		 * System.out.println(c);
		 */
	}
}
