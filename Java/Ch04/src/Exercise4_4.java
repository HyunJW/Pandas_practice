
public class Exercise4_4 {

	public static void main(String[] args) {
		int sum = 0, i = 0;
		
//		// solve 1.
//		while (sum < 100) {
//			i++;
//			sum += i*Math.pow(-1, (i+1)%2);
//		}
		// solve 2.
		for (i=1; sum<100; i++) {
			sum += i*Math.pow(-1, (i+1)%2);
		}
		System.out.println("result="+(i-1));
	}
}
