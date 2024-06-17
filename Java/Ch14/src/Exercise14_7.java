import java.util.*;
import java.util.stream.*;

public class Exercise14_7 {

	public static void main(String[] args) {
		new Random().ints(1, 46) // 1~45사이의 정수를 요소로 하는 무한 스트림
					.distinct() // 중복 제거
					.limit(6) // 6개 제한
					.sorted() // 정렬
					.forEach(System.out::println);
	}
}
