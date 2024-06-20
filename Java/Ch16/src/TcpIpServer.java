import java.net.*;
import java.io.*;
import java.util.Date;
import java.text.SimpleDateFormat;

public class TcpIpServer {
	public static void main(String[] args) {
		ServerSocket serverSocket = null;
		
		try {
			// server socket ���� �� 7777 ��Ʈ�� ����
			serverSocket = new ServerSocket(7777);
			System.out.println(getTime() + "������ �غ�Ǿ����ϴ�.");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		while (true) {
			try {
				System.out.println(getTime() + "�����û�� ��ٸ��ϴ�.");
				
				// Ŭ���̾�Ʈ �����û�� �� ������ �������� ���
				// �����û�� ������ Ŭ���̾�Ʈ ���ϰ� ����� ���ο� ���� ��
				Socket socket = serverSocket.accept();
				System.out.println(getTime() + 
						socket.getInetAddress() + "�κ��� �����û�� ���Խ��ϴ�.");
				
				// socket�� ��½�Ʈ��
				OutputStream out = socket.getOutputStream();
				DataOutputStream dos = new DataOutputStream(out);
				
				// ���� ����(remote socket)�� �����͸� ����
				dos.writeUTF("[Notice] Test Message1 from server.");
				System.out.println(getTime() + "�����͸� �����߽��ϴ�.");
				
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
