
public class Ex7_7 {

	public static void main(String[] args) {
		Car car = null; 
		FireEngine fe = new FireEngine();
		FireEngine fe2 = null;
		
		fe.water();
		car = fe; // ����ȯ ����
//		car.water() // ������ ����. CarŸ���� ���������� water()�� ȣ���� �� ����. 
		fe2 = (FireEngine)car; // ����Ÿ�� -> �ڼ�Ÿ�� (����ȯ ���� �Ұ�)
		fe2.water();
	}
}

class Car {
	String colorl;
	int door;
	
	void drive() {
		System.out.println("drive, Brrrr~");
	}
	
	void stop() {
		System.out.println("stop!!!");
	}
}

class FireEngine extends Car {
	void water() {
		System.out.println("water!!!");
	}
}