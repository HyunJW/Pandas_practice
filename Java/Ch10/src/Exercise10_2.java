import java.util.*;
import java.text.*;

public class Exercise10_2 {

	public static void main(String[] args) {
		String pattern = "yyyy/MM/dd";
		DateFormat df = new SimpleDateFormat(pattern);
		Scanner s = new Scanner(System.in);
		
		Date inDate = null;
		
		do {
			System.out.println("��¥�� " + pattern + "�� ���·� �Է����ּ���.(�Է¿�:2017/05/11)");
			
			try {
				System.out.print(">>");
				inDate = df.parse(s.nextLine());
				break;
			} catch (Exception e) {}
		} while (true);
		
		System.out.println(new SimpleDateFormat("�Է��Ͻ� ��¥�� E�����Դϴ�.").format(inDate));
		
		s.close();
	}
}
