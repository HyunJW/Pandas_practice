class Outer {
	int value = 10;
	
	class Inner {
		int iv = 100;
		int value = 20;
		
		void method1() {
			int value = 30;
			
			System.out.println(value);
			System.out.println(this.value);
			System.out.println(Outer.this.value);
		}
	}
	
	static class SInner {
		int iv = 200;
	}
}

public class Exercise7_6 {

	public static void main(String[] args) {
		// Exercise 7-6
		Outer outer = new Outer();
		Outer.Inner inner = outer.new Inner();
		System.out.println(inner.iv);
		
		// Exercise 7-7
		Outer.SInner si = new Outer.SInner();
		System.out.println(si.iv);
		
		// Exercise 7-8
		inner.method1();
	}
}
