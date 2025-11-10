package servlet;

import java.io.IOException;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.ShiftDAO;
/**
 * Servlet implementation class AdminShiftUpdateServlet
 */
@WebServlet("/AdminShiftUpdateServlet")
public class AdminShiftUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminShiftUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Map<String,String[]> paramMap = request.getParameterMap();
		
		for(String key: paramMap.keySet()) {
			if(key.startsWith("shift_")) {
				String[] parts = key.split("_", 3); // ["shift", "tanaka", "2025-10-01"]
		        String userId = parts[1];
		        String date = parts[2];
		        String type = request.getParameter(key);

		        if (type != null && !type.isEmpty()) {
		        	
		        	if ("〇".equals(type)) {
		                String timeKey = "time_" + userId + "_" + date;
		                String time = request.getParameter(timeKey);
		                if (time == null || time.isEmpty()) {
		                    request.setAttribute("error", "〇を選んだら時間帯も選んでください（" + userId + " / " + date + "）");
		                    request.getRequestDispatcher("/WEB-INF/jsp/adminshiftview.jsp").forward(request, response);
		                    return;
		                }

		            // DAOで更新処理
		        	new ShiftDAO().updateOrInsertShift(userId, date, type, time);

		        	}else {
		        		new ShiftDAO().updateOrInsertShift(userId, date, type, null);

		        	}
		       
		        }
			}
		}
	        response.sendRedirect("AdminShiftViewServlet?edit=false&saved=true");
		
	
		
	}
}
	
