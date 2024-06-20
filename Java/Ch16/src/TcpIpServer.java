import java.net.*;
import java.io.*;
import java.util.Date;
import java.text.SimpleDateFormat;

public class TcpIpServer {
	public static void main(String[] args) {
		ServerSocket serverSocket = null;
		
		try {
			// server socket 생성 후 7777 포트와 결합
			serverSocket = new ServerSocket(7777);
			System.out.println(getTime() + "서버가 준비되었습니다.");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		while (true) {
			try {
				System.out.println(getTime() + "연결요청을 기다립니다.");
				
				// 클라이언트 연결요청이 올 때까지 서버소켓 대기
				// 연결요청이 들어오면 클라이언트 소켓과 통신할 새로운 소켓 생
				Socket socket = serverSocket.accept();
				System.out.println(getTime() + 
						socket.getInetAddress() + "로부터 연결요청이 들어왔습니다.");
				
				// socket의 출력스트림
				OutputStream out = socket.getOutputStream();
				DataOutputStream dos = new DataOutputStream(out);
				
				// 원격 소켓(remote socket)에 데이터를 전송
				dos.writeUTF("[Notice] Test Message1 from server.");
				System.out.println(getTime() + "데이터를 전송했습니다.");
				
				// stream and socket close
				dos.close();
				socket.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	static String getTime() {
		SimpleDateFormat f = new SimpleDateFormat("[hh:mm:ss]");
		return f.format(new Date());
	}
}
