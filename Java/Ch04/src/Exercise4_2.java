
public class Exercise4_2 {

	public static void main(String[] args) {
		int n = 0;
		for (int i=1; i<=20; i++) {
			if ((i%2!=0)&&(i%3!=0))
				n += i;
		}
		System.out.println("reuslt="+ n);
	}
}