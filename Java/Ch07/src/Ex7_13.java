
public class Ex7_13 {

	class InstanceInner {}
	static class StaticInner{}
	
	InstanceInner iv = new InstanceInner(); // 인스턴스 멤버간에는 서로 직접 접근 가능
	static StaticInner cv = new StaticInner(); // static 멤버 간에는 서로 직접 접근 가능
	
	static void staticMethod() {
		StaticInner obj1 = new StaticInner(); // static 멤버는 인스턴스 멤버에 접근 불가
		
		// 인스턴스 멤버에 굳이 접근하기 위해서는 객체를 생성해야 함
		Ex7_13 outer = new Ex7_13();
		InstanceInner obj2 = outer.new InstanceInner();
	}
	
	void instanceMethod() {
		// 인스턴스 메서드에서는 인스턴스 멤버와 static 멤버 모두 접근 가능
		InstanceInner obj1 = new InstanceInner();
		StaticInner obj2 = new StaticInner();
		
		// 메서드 내에 지역적으로 선언된 내부 클래스는 외부에서 접근 불가
		// LocalInner lv = new LocalInner(); x
	}
	
	void myMethod() {
		class LocalInner {}
		LocalInner lv = new LocalInner();
	}
}
