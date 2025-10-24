package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
	public boolean updateOrInsertShift(String userId,String type,String date) {
		String updateSql = "UPDATE SHIFT_TABLE SET TYPE=? WHERE ID=? AND DATE=?";
	    String insertSql = "INSERT INTO SHIFT_TABLE(ID, DATE, TYPE) VALUES (?, ?, ?)";
	    
	    try(Connection conn = new DBConnection().getConnection("shift_db");
	    		PreparedStatement updatepStmt = conn.prepareStatement(updatesql)){
	    	
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
	public Map<String,List<Shift>> getAllShiftsGroupedByUser (){
		Map<String,List<Shift>> shiftMap = new LinkedHashMap<>();
		String sql = "SELECT user_id,shift_date,shift_type,shift_time FROM shifts ORDER BY user_id,shift_id";
		
		try (Connection conn = new DBConnection().getConnection("shift_db");
				PreparedStatement pStmt = conn.prepareStatement(sql);
				ResultSet rs = pStmt.executeQuery()){
				
			
			 while (rs.next()) {
				 	String id = rs.getString("user_id");
	                String date = rs.getString("shift_date");
	                String type = rs.getString("shift_type");
	                String time = rs.getString("shift_time");

	                Shift shift = new Shift(id, date, type,time);
	                
	                if(!shiftMap.containsKey(id)) {
	                	shiftMap.put(id, new ArrayList<Shift>());
	                }
	                shiftMap.get(id).add(shift);
			 }
		}catch(SQLException e) {
			e.printStackTrace();
		}return shiftMap;
	}
}