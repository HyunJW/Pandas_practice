
public class Exercise4_3 {

	public static void main(String[] args) {
//		// solve 1.
//		int sum = 0;
//		int tmp;
//		
//		for (int i=1; i<=10; i++) {
//			tmp = 0;
//			for (int j=1; j<=i; j++) {
//				tmp += j;
//			}
//			sum += tmp;
//		}
		// solve 2.
		int sum = 0, tmp = 0;
		
		for (int i=1; i<=10; i++) {
			tmp += i;
			sum += tmp;
		}
		System.out.println("result="+sum);
	}
}
