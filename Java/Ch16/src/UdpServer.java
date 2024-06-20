import java.net.*;
import java.io.*;
import java.util.Date;
import java.text.SimpleDateFormat;

public class UdpServer {
	public void start() throws IOException {
		DatagramSocket socket = new DatagramSocket(7777);
		DatagramPacket inPacket, outPacket;
		
		byte[] inMsg = new byte[10];
		byte[] outMsg;
		
		while (true) {
			// 데이터 수신을 위한 packet 생성
			inPacket = new DatagramPacket(inMsg, inMsg.length);
			socket.receive(inPacket); // packet을 통해 데이터 수신
			
			// 수신한 packet으로부터 client의 ip주소와 port를 얻음
			InetAddress address =inPacket.getAddress();
			int port = inPacket.getPort();
			
			// 서버의 현재시간을 시분초 형태로 반환
			SimpleDateFormat sdf = new SimpleDateFormat("[hh:mm:ss]");
			String time = sdf.format(new Date());
			outMsg = time.getBytes(); // time -> byte배열
			
			// packet을 생성해서 client에 전송
			outPacket = new DatagramPacket(outMsg, outMsg.length, address, port);
			socket.send(outPacket);
		}
	}
	
	public static void main(String[] args) {
		try {
			new UdpServer().start();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
