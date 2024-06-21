import java.util.*;
import java.time.*;

public class PrintAge {
	public static int solution1(int age) {
		int answer = 2022 - age + 1;
		return answer;
	}
	
	@SuppressWarnings("deprecation")
	public static int solution2(int age) {
		Date year = new Date();
		year.setYear(2022);
		int answer = year.getYear() - age + 1;
		return answer;
	}
	
	public static int solution3(int age) {
		LocalDate ld = LocalDate.of(2022,1,1);
		int year = ld.getYear();
		int answer = year - age + 1;
		return answer;
	}
	
	public static void main(String[] args) {
		int age = Integer.parseInt(args[0]);
		System.out.println(solution1(age));
		System.out.println(solution2(age));
		System.out.println(solution3(age));
	}
}
