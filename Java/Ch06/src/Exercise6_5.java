class PlayingCard {
	int kind; // kind: 인스턴스 변수
	int num; // num: 인스턴스 변수
	
	static int width; // width: 클래스 변수
	static int height; // height: 클래스 변수

	PlayingCard(int k, int n){ 
		kind = k; // k: 지역변수
		num = n; // n: 지역변수
	}
}

public class Exercise6_5 {

	public static void main(String[] args) { // args: 지역변수
		PlayingCard card = new PlayingCard(1, 1); // card: 지역변수
		System.out.println(card.kind);
	}
}
