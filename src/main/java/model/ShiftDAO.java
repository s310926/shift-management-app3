package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ShiftDAO {
	public boolean insertShift(String id, String date, String shift,String time) {
		String sql = "INSERT INTO SHIFT_TABLE(ID,DATE,TYPE,TIME) VALUES(?,?,?,?)";
		//Connection conn = new DBConnection().getConnection("shift_db");
		
		try (Connection conn = new DBConnection().getConnection("shift_db");
				PreparedStatement pStmt = conn.prepareStatement(sql)){
			
		
		
		
		pStmt.setString(1, id);
		pStmt.setString(2,date);
		pStmt.setString(3,shift);
		pStmt.setString(4,time);
		
		int result = pStmt.executeUpdate();
		return result ==1;
		
		
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		
		
		}
	}
	public List<Shift> getShiftsByUser(String userId){
		List<Shift> shiftList = new ArrayList<>();
		String sql = "SELECT DATE, TYPE FROM SHIFT_TABLE WHERE ID=? ORDER BY DATE";
		
		try (Connection conn = new DBConnection().getConnection("shift_db");
				PreparedStatement pStmt = conn.prepareStatement(sql)){
	
			 pStmt.setString(1, userId);

		        try (ResultSet rs = pStmt.executeQuery()) {
		            while (rs.next()) {
		                String date = rs.getString("DATE");
		                String type = rs.getString("TYPE");

		                Shift shift = new Shift(userId, date, type);
		                shiftList.add(shift);
		            }
		        }

		    } catch (SQLException e) {
		        e.printStackTrace();
		    }

		    return shiftList;
		    
	}
}