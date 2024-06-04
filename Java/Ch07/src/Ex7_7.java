
public class Ex7_7 {

	public static void main(String[] args) {
		Car car = null; 
		FireEngine fe = new FireEngine();
		FireEngine fe2 = null;
		
		fe.water();
		car = fe; // 형변환 생략
//		car.water() // 컴파일 에러. Car타입의 참조변수는 water()를 호출할 수 없음. 
		fe2 = (FireEngine)car; // 조상타입 -> 자손타입 (형변환 생략 불가)
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