package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegisterDAO {
	public boolean insertLogin(String id, String name, String pass) {
		String sql = "INSERT INTO LOGIN_TABLE(ID,NAME,PASS) VALUES(?,?,?)";
		//Connection conn = new DBConnection().getConnection("login_db");
		try (Connection conn = new DBConnection().getConnection("login_db");
				PreparedStatement pStmt = conn.prepareStatement(sql)){
			
			pStmt.setString(1, id);
			pStmt.setString(2,name);
			pStmt.setString(3,pass);
			
			int result = pStmt.executeUpdate();
			return result ==1;
			
			
			}catch(SQLException e) {
				e.printStackTrace();
				return false;
		}
	}
}
