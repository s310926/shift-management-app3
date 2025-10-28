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
	public boolean insertShift(String userId, String date, String shift,String time) {
		String sql = "INSERT INTO shift_table(USER_ID,DATE,TYPE,TIME) VALUES(?,?,?,?)";
		//Connection conn = new DBConnection().getConnection("shift_db");
		
		try (Connection conn = new DBConnection().getConnection("shift_db");
				PreparedStatement pStmt = conn.prepareStatement(sql)){
			
		
		pStmt.setString(1, userId);
		pStmt.setString(2,date);
		pStmt.setString(3,shift);
		pStmt.setString(4,time);
		
		int result = pStmt.executeUpdate();

		return result ==1;
		
//	
		
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		
		
		}
	}
	public boolean updateOrInsertShift(String userId,String date,String type,String time) {
		String updateSql = "UPDATE shift_table SET TYPE=?, TIME=? WHERE USER_ID=? AND DATE=?";
	    String insertSql = "INSERT INTO shift_table(USER_ID, DATE, TYPE,TIME) VALUES (?, ?,?,?)";
	    
	    try(Connection conn = new DBConnection().getConnection("shift_db");
	    		PreparedStatement updateStmt = conn.prepareStatement(updateSql)){
	    	
	    	updateStmt.setString(1,type);
	    	updateStmt.setString(2,time);
	    	updateStmt.setString(3,userId);
	    	updateStmt.setString(4,date);
	    	
	    	
	    	int result = updateStmt.executeUpdate();
	    	
	    	if(result == 0) {
	    		try(PreparedStatement insertStmt = conn.prepareStatement(insertSql)){
	    				insertStmt.setString(1,userId);
	    				insertStmt.setString(2,date);
	    				insertStmt.setString(3,type);
	    				insertStmt.setString(4,time);
	    				insertStmt.executeUpdate();
	    	}
	    	}
	    	return true;
	    }catch(SQLException e) {
			e.printStackTrace();
			return false;
	    }
	}
	public List<Shift> getShiftsByUser(String userId){
		List<Shift> shiftList = new ArrayList<>();
		String sql = "SELECT USER_ID, DATE, TYPE,TIME FROM shift_table WHERE USER_ID=? ORDER BY USER_ID, DATE";
		
		try (Connection conn = new DBConnection().getConnection("shift_db");
				PreparedStatement pStmt = conn.prepareStatement(sql)){
	
			 pStmt.setString(1, userId);

		        try (ResultSet rs = pStmt.executeQuery()) {
		            while (rs.next()) {
		                String date = rs.getString("DATE");
		                String type = rs.getString("TYPE");
		                String time = rs.getString("TIME");

		                Shift shift = new Shift(userId, date, type,time);
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
		String sql = "SELECT USER_ID,DATE,TYPE,TIME FROM shift_table ORDER BY user_id,DATE";
		
		try (Connection conn = new DBConnection().getConnection("shift_db");
				PreparedStatement pStmt = conn.prepareStatement(sql);
				ResultSet rs = pStmt.executeQuery()){
				
			
			 while (rs.next()) {
				 	
				 	String userId = rs.getString("USER_ID");
	                String date = rs.getString("DATE");
	                String type = rs.getString("TYPE");
	                String time = rs.getString("TIME");

	                Shift shift = new Shift(userId, date, type,time);
	                
	                if(!shiftMap.containsKey(userId)) {
	                	shiftMap.put(userId, new ArrayList<Shift>());
	                }
	                shiftMap.get(userId).add(shift);
			 }
		}catch(SQLException e) {
			e.printStackTrace();
		}return shiftMap;
	}
	public List<Shift> findAllShifts() {
	    List<Shift> shiftList = new ArrayList<>();
	    String sql = "SELECT USER_ID, DATE, TYPE, TIME FROM shift_table ORDER BY DATE";

	    try (Connection conn = new DBConnection().getConnection("shift_db");
	         PreparedStatement pStmt = conn.prepareStatement(sql);
	         ResultSet rs = pStmt.executeQuery()) {

	        while (rs.next()) {
	            String userId = rs.getString("USER_ID");
	            String date = rs.getString("DATE");
	            String type = rs.getString("TYPE");
	            String time = rs.getString("TIME");

	            Shift shift = new Shift(userId, date, type, time);
	            shiftList.add(shift);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return shiftList;
	}
}