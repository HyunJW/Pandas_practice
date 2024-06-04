class Product3 {
	int price;
	int bonusPoint;
	
	Product3() {}
	
	Product3(int price){
		this.price = price;
		bonusPoint = (int)(price / 10.0);
	}
}

class Tv3 extends Product3 {
	Tv3() {}
	
	public String toString() {
		return "Tv";
	}
}

public class Exercise7_3 {

	public static void main(String[] args) {
		Tv3 t = new Tv3();
	}
}
