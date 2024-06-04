
public class Ex7_12 {
	class InstanceInner {
		int iv = 100; // static���� ���� �Ұ�
		final static int CONST = 100; // final static�� ����̹Ƿ� ���
	}
	
	static class StaticInner {
		int iv = 200;
		static int cv = 200; // static Ŭ������ static ��� ���� ����
	}
	
	void myMethod() {
		class LocalInner {
			int iv = 300; // static���� ���� �Ұ�
			final static int CONST = 300; // final static�� ����̹Ƿ� ���
		}
	}
	
	public static void main(String[] args) {
		System.out.println(InstanceInner.CONST);
		System.out.println(StaticInner.cv);
	}
}
