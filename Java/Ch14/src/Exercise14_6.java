import java.util.*;
import java.util.stream.*;

public class Exercise14_6 {

	public static void main(String[] args) {
		String[] strArr = {"aaa", "bb", "c", "dddd"};
		Stream<String> strStream = Stream.of(strArr);
		
		strStream.map(String::length)
				.sorted(Comparator.reverseOrder())
				.limit(1)
				.forEach(System.out::println);;
		
	}
}
