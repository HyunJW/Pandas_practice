class PlayingCard {
	int kind; // kind: �ν��Ͻ� ����
	int num; // num: �ν��Ͻ� ����
	
	static int width; // width: Ŭ���� ����
	static int height; // height: Ŭ���� ����

	PlayingCard(int k, int n){ 
		kind = k; // k: ��������
		num = n; // n: ��������
	}
}

public class Exercise6_5 {

	public static void main(String[] args) { // args: ��������
		PlayingCard card = new PlayingCard(1, 1); // card: ��������
		System.out.println(card.kind);
	}
}
