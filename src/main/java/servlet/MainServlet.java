package servlet;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Shift;
import model.ShiftDAO;
import model.ShiftDateGenerator;
import model.User;

/**
 * Servlet implementation class MainServlet
 */
@WebServlet("/MainServlet")
public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MainServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) +1;
		
		ShiftDateGenerator generator = new ShiftDateGenerator();
		List<List<String>> calendar = generator.getCalendarGrid(year, month);
		request.setAttribute("calendar", calendar);
		
		//ログインユーザーからシフト情報を取得
		User loginUser = (User)request.getSession().getAttribute("loginUser");
		if(loginUser != null) {
			String userId = loginUser.getUserId();
			ShiftDAO dao = new ShiftDAO();
			Map<String,Shift>ShiftMap = dao.getShiftMap(userId,year,month);
			request.setAttribute("shiftMap",ShiftMap);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/shiftadd.jsp");
		dispatcher.forward(request, response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 Calendar cal = Calendar.getInstance();
		    int year = cal.get(Calendar.YEAR);
		    int month = cal.get(Calendar.MONTH) + 1;
		    
		    ShiftDateGenerator generator = new ShiftDateGenerator();
		    List<List<String>> calendar = generator.getCalendarGrid(year, month);

		    for (List<String> week : calendar) {
		        for (String day : week) {
		            if (day != null && day.length() == 10 && day.contains("-") && !day.contains("--") && !day.equals("---")) {
		                String shift = request.getParameter("shift_" + day);
		                String time = request.getParameter("time_" + day);
		                System.out.println("日付: " + day + " / シフト: " + shift + " / 時間: " + time);
		               
		            }
		        }
		    }

		    request.setAttribute("calendar", calendar);
		    User loginUser = (User)request.getSession().getAttribute("loginUser");
			if(loginUser != null) {
				String userId = loginUser.getUserId();
				ShiftDAO dao = new ShiftDAO();
				Map<String,Shift>ShiftMap = dao.getShiftMap(userId,year,month);
				request.setAttribute("shiftMap",ShiftMap);
			}
		    
		    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/shiftresult.jsp");
		    dispatcher.forward(request, response);
		


	}

}
