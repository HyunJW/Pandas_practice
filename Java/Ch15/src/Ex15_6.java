import java.io.*;

public class Ex15_6 {
	public static void main(String[] args) {
		try {
			FileOutputStream fos = new FileOutputStream("123.txt");
			BufferedOutputStream bos = new BufferedOutputStream(fos, 5);
			
			for (int i='1'; i<='9'; i++) { // char로 받지 않으면 인코딩 깨짐
				bos.write(i);
			}
			
//			fos.close(); // BufferedOutputStream의 버퍼에 있는 내용 출력 x, result = 12345
			bos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
