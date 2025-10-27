package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserDAO {
    public boolean insertUser(User user) {
        String sql = "INSERT INTO USER_TABLE(ID, NAME, PASS, ROLE) VALUES (?, ?, ?, ?)";

        try (Connection conn = new DBConnection().getConnection("shift_db");
             PreparedStatement pStmt = conn.prepareStatement(sql)) {

            pStmt.setString(1, user.getId());
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
}