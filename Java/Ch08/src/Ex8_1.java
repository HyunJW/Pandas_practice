
public class Ex8_1 {

	public static void main(String[] args) {
		System.out.println(1);
		try {
			System.out.println(2);
			System.out.println(3);
		} catch (Exception e) {
			System.out.println(4); // ½ÇÇà x
		}
		System.out.println(5);
	}
}
