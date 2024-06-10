import java.util.*;
import java.text.*;

public class Exercise10_4 {

	public static void main(String[] args) {
		Calendar date = Calendar.getInstance();
		Calendar today = Calendar.getInstance();
		String pattern = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		
		Scanner s = new Scanner(System.in);
		
		while (true) {
			try {
				System.out.print("birth day=");
				Date inDate = sdf.parse(s.nextLine());
				date.setTime(inDate);
				break;
			} catch (Exception e) {
				System.out.println("형식에 맞춰서 입력해주세요.(ex. 2000-05-05)");
			}
		}
		
		System.out.println("today=" + sdf.format(new Date(today.getTimeInMillis())));
		
		long difference = (today.getTimeInMillis() - date.getTimeInMillis()) / (1000*24*60*60);
		System.out.println(difference + " days");
		
		s.close();
	}
}
