package model;

import java.io.Serializable;

public class User implements Serializable{
	private String id;
	private String name;
	private String pass;
	private String role;
	
	public User() {}
	public User(String id,String name,String pass,String role) {
		this.id = id;
		this.name = name;
		this.pass = pass;
		this.role = role;
	}
	public String getId() {return id;}
	public String getName() {return name;}
	public String getPass() {return pass;}
	public String getRole() {return role;}

}