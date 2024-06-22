
public class DiscountClothes {
	public static int solution(int price) {
		double ratio = (price>=500000) ? 0.8: (price>=300000) ? 0.9: (price>=100000) ? 0.95: 1;
		return  (int)(price*ratio);
	}
	
	public static void main(String[] args) {
		System.out.println(solution(150000));
		System.out.println(solution(580000));
	}
}
