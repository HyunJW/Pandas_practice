
public class Ex3_11 {

	public static void main(String[] args) {
		double pi = 3.141592;
		double shortPi = Math.round(pi*1000) / 1000.0;
		
		System.out.println(shortPi);
		
		/*
		 * Math.round(): �Ҽ��� ù° �ڸ����� �ݿø�
		 * pi*1000 -> 3141.592
		 * Math.round(pi*1000) -> 3142
		 * Math.round(pi*1000) / 1000.0 -> 3.142
		 * Math.round(pi*1000) / 1000 -> 3
		 */
	}
}
