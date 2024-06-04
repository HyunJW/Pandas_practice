class SutdaDeck {
	final int CARD_NUM = 20;
	SutdaCard[] cards = new SutdaCard[CARD_NUM];
	
	SutdaDeck() {
		for (int i=0; i<cards.length; i++) {
			int num = i%10 + 1;
			boolean isKwang = (i < 10) && (num==1 || num==3 || num==8);
			
			cards[i] = new SutdaCard(num, isKwang);
		}
	}
	
	void shuffle(){
		for (int i=0; i<cards.length; i++) {
			int idx = (int)(Math.random()*cards.length);
			
			SutdaCard tmp = cards[i];
			cards[i] = cards[idx];
			cards[idx] = tmp;
		}
	}
	
	SutdaCard pick(int index) {
		if (index < 0 || index >= CARD_NUM) 
			return null;
		return cards[index];
	}
	
	SutdaCard pick() {
		int index = (int)(Math.random()*cards.length);
		return cards[index];
	}
}

class SutdaCard {
	int num;
	boolean isKwang;
	
	SutdaCard() {
		this(1, true);
	}
	
	SutdaCard(int num, boolean isKwang) {
		this.num = num;
		this.isKwang = isKwang;
	}
	
	public String toString() {
		return num + (isKwang ? "K": "");
	}
}

public class Exercise7_1 {

	public static void main(String[] args) {
		SutdaDeck deck = new SutdaDeck();
		
		// Exercise 7-2
		System.out.println(deck.pick(0));
		System.out.println(deck.pick());
		
		deck.shuffle();
		// Exercise 7-1
		for (int i=0; i<deck.cards.length; i++) {
			System.out.printf(i < deck.CARD_NUM-1 ? "%s, ": "%s", deck.cards[i], deck.cards[i]);
		}
		
		System.out.println();
		System.out.println(deck.pick(0));
	}
}
