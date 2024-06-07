import java.util.*;
import java.text.*;

public class Exercise10_2 {

	public static void main(String[] args) {
		String pattern = "yyyy/MM/dd";
		DateFormat df = new SimpleDateFormat(pattern);
		Scanner s = new Scanner(System.in);
		
		Date inDate = null;
		
		do {
			System.out.println("날짜를 " + pattern + "의 형태로 입력해주세요.(입력예:2017/05/11)");
			
			try {
				System.out.print(">>");
				inDate = df.parse(s.nextLine());
				break;
			} catch (Exception e) {}
		} while (true);
		
		System.out.println(new SimpleDateFormat("입력하신 날짜는 E요일입니다.").format(inDate));
		
		s.close();
	}
}
