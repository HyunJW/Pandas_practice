
public class Ex3_9 {

	public static void main(String[] args) {
		int a = 1_000_000;
		int b = 2_000_000;
		
		long c = a * b; // a * b �� ���� int���̹Ƿ� long�� ������ �־ ������ ����
		
		System.out.println(c);
		
		c = a * (long)b; // a, b �� �ϳ��� long���� ����ȯ �� �����ؾ� �ùٸ� ����� ����
		
		System.out.println(c);
	}
}
