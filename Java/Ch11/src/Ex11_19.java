import java.util.*;
import static java.util.Collections.*;

public class Ex11_19 {

	public static void main(String[] args) {
		List list = new ArrayList();
		System.out.println(list);
		
		addAll(list, 1, 2, 3, 4, 5);
		System.out.println(list);
		
		rotate(list, 2); // 오른쪽으로 두칸씩 이동
		System.out.println(list);
		
		swap(list, 0, 2); // 1번째와 3번째 교환
		System.out.println(list);
		
		shuffle(list);
		System.out.println(list);
		System.out.println();
		
		sort(list, reverseOrder()); // reverse(list)와 동일, 역순 정렬
		System.out.println(list);
		
		sort(list);
		System.out.println(list);
		System.out.println();
		
		int idx = binarySearch(list, 3); // 3이 저장된 위치 반환
		System.out.println("index of 3=" + idx);
		System.out.println();
		
		System.out.println("max=" + max(list));
		System.out.println("min=" + min(list));
		System.out.println("min=" + max(list, reverseOrder()));
		System.out.println();
		
		fill(list, 9);
		System.out.println("list=" + list);
		
		List newList = nCopies(list.size(), 2);
		System.out.println("newList=" + newList);
		System.out.println();
		
		System.out.println(disjoint(list, newList)); // 공통 요소가 없으면 true
		System.out.println();
		
		copy(list, newList);
		System.out.println("list=" + list);
		System.out.println("newList=" + newList);
		System.out.println();
		
		replaceAll(list, 2, 1);
		System.out.println("list=" + list);
		System.out.println();
		
		Enumeration e = enumeration(list);
		ArrayList list2 = list(e);
		
		System.out.println("list2=" + list2);
	}
}
