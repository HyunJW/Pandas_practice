
public class Exercise13_1 {

	public static void main(String[] args) {
		Runnable1 r1 = new Runnable1();
		Thread t1 = new Thread(r1);
		// Thread t1 = new Thread(new Runnable1());
		t1.start();
	}
}

class Runnable1 implements Runnable {
	public void run() {
		for (int i=0; i<300; i++)
			System.out.print("-");
	}
}