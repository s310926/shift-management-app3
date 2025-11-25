package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public boolean insertUser(User user) {
        String sql = "INSERT INTO user_table(USER_ID, NAME, PASSWORD, ROLE) VALUES (?, ?, ?, ?)";
        try(Connection conn = DBConnection.getConnection("shift_db")){
        if (conn == null) {
//            System.out.println("DB接続失敗: conn が null");
            return false;
        }
        
//        System.out.println("DAO: DB接続成功");

		try (
             PreparedStatement pStmt = conn.prepareStatement(sql)) {
//			System.out.println("DAO: SQL準備成功");
            pStmt.setString(1, user.getUserId());
            pStmt.setString(2, user.getName());
            pStmt.setString(3, user.getPass());
            pStmt.setString(4, user.getRole());

            int result = pStmt.executeUpdate();
//            System.out.println("登録結果: " + result);

            return result == 1;
		}

        } catch (SQLException e) {
//        	System.out.println("SQLエラー: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
       }
    
    public User findByIdAndPassword(String userId,String name,String pass) {
    	String sql="SELECT * FROM user_table WHERE USER_ID = ? AND NAME = ? AND PASSWORD = ?";
    	
    	
		try(Connection conn = DBConnection.getConnection("shift_db");
    			PreparedStatement pStmt = conn.prepareStatement(sql)){
    		
    		pStmt.setString(1, userId);
    		pStmt.setString(2, name);
    		pStmt.setString(3, pass);
    		
    		ResultSet rs = pStmt.executeQuery();
    		if(rs.next()) {
    			String dbname = rs.getString("NAME");
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