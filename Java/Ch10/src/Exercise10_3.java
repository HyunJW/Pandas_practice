import java.util.*;
import java.text.*;

public class Exercise10_3 {
	
	static int paycheckCount(Calendar from, Calendar to) {
		if (from == null || to == null)
			return 0;
		
		if (from.equals(to) && from.get(Calendar.DATE)==21)
			return 1;
		
		int fromYear = from.get(Calendar.YEAR);
		int fromMon = from.get(Calendar.MONTH);
		int fromDay = from.get(Calendar.DATE);
		
		int toYear = to.get(Calendar.YEAR);
		int toMon = to.get(Calendar.MONTH);
		int toDay = to.get(Calendar.DATE);
		
		int monDiff = (toYear*12 + toMon) - (fromYear*12 + fromMon);
		
		if (monDiff < 0)
			return 0;
		
		if (fromDay <= 21 && toDay >= 21)
			monDiff++;
		
		if (fromDay > 21 && toDay < 21)
			monDiff--;
		
		return monDiff;
	}
	
	static void printResult(Calendar from, Calendar to) {
		Date fromDate = from.getTime();
		Date toDate = to.getTime();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		System.out.print(sdf.format(fromDate) + " ~ " + sdf.format(toDate) + ": ");
		System.out.println(paycheckCount(from, to));
	}

	public static void main(String[] args) {
		Calendar fromCal = Calendar.getInstance();
		Calendar toCal = Calendar.getInstance();
		
		fromCal.set(2020, 0, 1);
		toCal.set(2020, 0, 1);
		printResult(fromCal, toCal);
		
		fromCal.set(2020, 0, 21);
		toCal.set(2020, 0, 21);
		printResult(fromCal, toCal);
		
		fromCal.set(2020, 0, 1);
		toCal.set(2020, 2, 1);
		printResult(fromCal, toCal);
		
		fromCal.set(2020, 0, 1);
		toCal.set(2020, 2, 23);
		printResult(fromCal, toCal);
		
		fromCal.set(2020, 0, 23);
		toCal.set(2020, 2, 21);
		printResult(fromCal, toCal);
		
		fromCal.set(2021, 0, 22);
		toCal.set(2020, 2, 21);
		printResult(fromCal, toCal);
	}
}
