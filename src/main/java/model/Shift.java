package model;

public class Shift {
	private String id;
	private String date;
	private String type;
	
	public Shift(String id, String date, String type) {
		this.id = id;
		this.date = date;
		this.type = type;
	}
	
	public String getId() {return id;}
	public String getDate() {return date;}
	public String getType() {return type;}
}
