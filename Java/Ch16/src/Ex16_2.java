import java.net.*;

public class Ex16_2 {
	public static void main(String[] args) throws Exception{
		URL url = new URL("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%9E%90%EB%B0%94%EC%9D%98+%EC%A0%95%EC%84%9D");
		
		System.out.println("url.getAuthority(): " + url.getAuthority());
		System.out.println("url.getContent(): " + url.getContent());
		System.out.println("url.getDefaultPort(): " + url.getDefaultPort());
		System.out.println("url.getPort(): " + url.getPort());
		System.out.println("url.getFile(): " + url.getFile());
		System.out.println("url.getHost(): " + url.getHost());
		System.out.println("url.getPath(): " + url.getPath());
		System.out.println("url.getProtocol(): " + url.getProtocol());
		System.out.println("url.getQuery(): " + url.getQuery());
		System.out.println("url.getRef(): " + url.getRef());
		System.out.println("url.getUserInfo(): " + url.getUserInfo());
		System.out.println("url.toExternalForm(): " + url.toExternalForm());
		System.out.println("url.toURI(): " + url.toURI());		
	}
}
