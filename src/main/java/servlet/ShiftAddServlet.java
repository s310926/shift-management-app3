package servlet;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.ShiftDAO;
import model.ShiftDateGenerator;
import model.User;

/**
 * Servlet implementation class ShiftAddServlet
 */
@WebServlet("/ShiftAddServlet")
public class ShiftAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShiftAddServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) +1;
		
		ShiftDateGenerator generator = new ShiftDateGenerator();
		List<List<String>> calendar = generator.getCalendarGrid(year,month);
		request.setAttribute("calendar",calendar);
		
		
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
		int month = cal.get(Calendar.MONTH) +1;
		
		ShiftDateGenerator generator = new ShiftDateGenerator();
		List<String> dates = generator.getDates(year, month);
		
		User loginUser = (User)request.getSession().getAttribute("loginUser");
		String userId = loginUser.getId();
		
		ShiftDAO dao = new ShiftDAO();
		for(String date: dates) {
		String shift = request.getParameter("shift_" + date);
		String time = request.getParameter("time_" + date);
		String cleaned = date.trim()
			    .replaceAll("[\\s\\u200B]", ""); // 空白・ゼロ幅スペースを除去
			request.setAttribute("cleanDay", cleaned);
		if ("〇".equals(shift)) {
	        dao.insertShift(userId, date, shift, time); // ← DAOに時間付きで渡す
	    } else {
	        dao.insertShift(userId, date, shift, null); // ← 時間なし
	    }

		
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/result.jsp");
		dispatcher.forward(request, response);
		
		
		
	}

}
