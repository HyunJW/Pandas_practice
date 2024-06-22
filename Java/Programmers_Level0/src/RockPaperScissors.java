import java.util.Arrays;
import java.util.stream.*;
import java.util.*;

public class RockPaperScissors {
	public static String solution1(String rsp) {
		return Arrays.stream(rsp.split(""))
				.map(s -> s.equals("2") ? "0": s.equals("0") ? "5": "2")
				.collect(Collectors.joining());
	}
	
	public static String solution2(String rsp) {
		Map<String, String> RSP = new HashMap<String, String>();
		RSP.put("2", "0");
		RSP.put("0", "5");
		RSP.put("5", "2");
		
		StringBuilder answer = new StringBuilder();
		
		for (int i=0; i<rsp.length(); i++)
			answer.append(RSP.get(rsp.substring(i, i+1)));
		
		return answer.toString();
	}
	
	public static void main(String[] args) {
		String rsp1 = "2";
		String rsp2 = "205";
		
		System.out.println(solution1(rsp1));
		System.out.println(solution1(rsp2));
		System.out.println(solution2(rsp1));
		System.out.println(solution2(rsp2));
	}
}
