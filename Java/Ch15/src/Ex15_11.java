import java.io.*;

public class Ex15_11 {
	public static void main(String[] args) {
		try {
			FileReader fr = new FileReader("./src/Ex15_11.java");
			BufferedReader br = new BufferedReader(fr);
			
			String line = "";
			for (int i=1; (line=br.readLine())!=null; i++) {
				if (line.indexOf(";") != -1)
					System.out.println(i + ": " + line);
			}
			
			br.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
