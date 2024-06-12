import java.util.*;

class Product {}
class Tv extends Product {}
class Audio extends Product {}

public class Ex12_1 {

	public static void main(String[] args) {
		ArrayList<Product> ProductList = new ArrayList<Product>();
		ArrayList<Tv> tvList = new ArrayList<Tv>();
		// ArrayList<Product> tvList = new ArrayList<Tv>(); // error
		// List<Tv> tvList = new ArrayList<Tv>(); // ok.
		
		ProductList.add(new Tv());
		ProductList.add(new Audio());
		
		tvList.add(new Tv());
		tvList.add(new Tv());
		
		printAll(ProductList);
	}
	
	public static void printAll(ArrayList<Product> list) {
		for (Product p: list) {
			System.out.println(p);
		}
	}
}
