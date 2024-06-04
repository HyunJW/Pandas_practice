class MyTv {
	private boolean isPowerOn;
	private int channel;
	private int volume;
	private int prevChannel;
	
	final int MAX_VOLUME = 100;
	final int MIN_VOLUME = 0;
	final int MAX_CHANNEL = 100;
	final int MIN_CHANNEL = 1;
	
	public void setPower() {
		isPowerOn = !isPowerOn;
	}
	
	public void setChannel(int channel) {
		if (channel < MIN_CHANNEL || channel > MAX_CHANNEL)
			return;
		
		this.prevChannel = this.channel;
		this.channel = channel;
	}
	
	public void setVolume(int volume) {
		if (volume < MIN_VOLUME || volume > MAX_VOLUME)
			return;
		this.volume = volume;
	}
	
	int getChannel() {
		return channel;
	}
	
	int getVolume() {
		return volume;
	}
	
	public void gotoPrevChannel() {
		setChannel(prevChannel);
	}
}

public class Exercise7_4 {

	public static void main(String[] args) {
		MyTv t = new MyTv();
		// Exercise 7-4
		t.setVolume(20);
		System.out.println("VOL: " + t.getVolume());
		
		t.setChannel(10);
		System.out.println("CH: " + t.getChannel());
		
		// Exercise 7-5
		t.setChannel(20);
		System.out.println("CH: " + t.getChannel());
		
		t.gotoPrevChannel();
		System.out.println("CH: " + t.getChannel());
		
		t.gotoPrevChannel();
		System.out.println("CH: " + t.getChannel());
	}
}	
