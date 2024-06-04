
public class Ex7_13 {

	class InstanceInner {}
	static class StaticInner{}
	
	InstanceInner iv = new InstanceInner(); // �ν��Ͻ� ��������� ���� ���� ���� ����
	static StaticInner cv = new StaticInner(); // static ��� ������ ���� ���� ���� ����
	
	static void staticMethod() {
		StaticInner obj1 = new StaticInner(); // static ����� �ν��Ͻ� ����� ���� �Ұ�
		
		// �ν��Ͻ� ����� ���� �����ϱ� ���ؼ��� ��ü�� �����ؾ� ��
		Ex7_13 outer = new Ex7_13();
		InstanceInner obj2 = outer.new InstanceInner();
	}
	
	void instanceMethod() {
		// �ν��Ͻ� �޼��忡���� �ν��Ͻ� ����� static ��� ��� ���� ����
		InstanceInner obj1 = new InstanceInner();
		StaticInner obj2 = new StaticInner();
		
		// �޼��� ���� ���������� ����� ���� Ŭ������ �ܺο��� ���� �Ұ�
		// LocalInner lv = new LocalInner(); x
	}
	
	void myMethod() {
		class LocalInner {}
		LocalInner lv = new LocalInner();
	}
}
