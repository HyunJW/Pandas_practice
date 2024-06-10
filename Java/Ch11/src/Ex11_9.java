import java.util.*;

public class Ex11_9 {

	public static void main(String[] args) {
		Object[] objArr = {"1", new Integer(1), "2", "2", "3", "3", "4", "4", "4"};
		Set set = new HashSet();
		
		for (int i=0; i<objArr.length; i++) {
			set.add(objArr[i]);
		}
		
		System.out.println(set); // [1(String), 1(Integer), 2, 3, 4]
		
		Iterator it = set.iterator();
		
		while (it.hasNext()) {
			System.out.println(it.next());
		}
	}
}
