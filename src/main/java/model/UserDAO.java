package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public boolean insertUser(User user) {
        String sql = "INSERT INTO user_table(USER_ID, NAME, PASS, ROLE) VALUES (?, ?, ?, ?)";

        try (Connection conn = new DBConnection().getConnection("shift_db");
             PreparedStatement pStmt = conn.prepareStatement(sql)) {

            pStmt.setString(1, user.getUserId());
            pStmt.setString(2, user.getName());
            pStmt.setString(3, user.getPass());
            pStmt.setString(4, user.getRole());

            int result = pStmt.executeUpdate();
            return result == 1;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public User findByIdAndPassword(String userId,String pass) {
    	String sql="SELECT * FROM user_table WHERE USER_ID = ? AND PASS = ?";
    	
    	try(Connection conn = new DBConnection().getConnection("shift_db");
    			PreparedStatement pStmt = conn.prepareStatement(sql)){
    		
    		pStmt.setString(1, userId);
    		pStmt.setString(2, pass);
    		
    		ResultSet rs = pStmt.executeQuery();
    		if(rs.next()) {
    			String name = rs.getString("NAME");
    			String role = rs.getString("ROLE");
    			return new User(userId, name, pass,role);
    		}else {
    			return null;
    		}
    	}catch(SQLException e) {
    		e.printStackTrace();
    		return null;
    	}
    }
}