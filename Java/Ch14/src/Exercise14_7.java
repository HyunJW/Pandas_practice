import java.util.*;
import java.util.stream.*;

public class Exercise14_7 {

	public static void main(String[] args) {
		new Random().ints(1, 46) // 1~45������ ������ ��ҷ� �ϴ� ���� ��Ʈ��
					.distinct() // �ߺ� ����
					.limit(6) // 6�� ����
					.sorted() // ����
					.forEach(System.out::println);
	}
}
