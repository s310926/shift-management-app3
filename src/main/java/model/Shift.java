package model;

public class Shift {
	private String userId;
	private String date;
	private String type;
	private String time;

	
	public Shift(String UserId, String date, String type, String time) {
		this.userId = userId;
		this.date = date;
		this.type = type;
		this.time = time;

	}
	

	public String getUserId() { return userId; }
	public String getDate() {return date;}
	public String getType() {return type;}
	public String getTime() { return time; }
	

}
