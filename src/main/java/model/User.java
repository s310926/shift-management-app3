package model;

import java.io.Serializable;

public class User implements Serializable{
	private String userId;
	private String name;
	private String pass;
	private String role;
	
	public User() {}
	public User(String userId,String name,String pass,String role) {
		this.userId = userId;
		this.name = name;
		this.pass = pass;
		this.role = role;
	}
	public String getUserId() {return userId;}
	public String getName() {return name;}
	public String getPass() {return pass;}
	public String getRole() {return role;}

}