package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegisterDAO {
	public boolean insertLogin(String userId, String name, String password,String role) {
		String sql = "INSERT INTO user_table(USER_ID,NAME,PASSWORD,ROLE) VALUES(?,?,?,?)";
	
		//Connection conn = new DBConnection().getConnection("login_db");
		try (Connection conn = DBConnection.getConnection("shift_db");
				PreparedStatement pStmt = conn.prepareStatement(sql)){
			
			pStmt.setString(1, userId);
			pStmt.setString(2,name);
			pStmt.setString(3,password);
			pStmt.setString(4,role);
			
			int result = pStmt.executeUpdate();
			return result ==1;
			
			
			}catch(SQLException e) {
				e.printStackTrace();
				return false;
		}
	}
}
