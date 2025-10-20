package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ShiftDAO {
	public boolean insertShift(String id, String date, String shift) {
		String sql = "INSERT INTO SHIFT_TABLE(ID,DATE,TYPE) VALUES(?,?,?)";
		//Connection conn = new DBConnection().getConnection("shift_db");
		
		try (Connection conn = new DBConnection().getConnection("shift_db");
				PreparedStatement pStmt = conn.prepareStatement(sql)){
			
		
		
		
		pStmt.setString(1, id);
		pStmt.setString(2,date);
		pStmt.setString(3,shift);
		
		int result = pStmt.executeUpdate();
		return result ==1;
		
		
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		
		
		}
	}
}
