package servlet;

import java.io.IOException;
import java.util.HashMap;
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
 * Servlet implementation class MonthSwitchServlet
 */
@WebServlet("/MonthSwitchServlet")
public class MonthSwitchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MonthSwitchServlet() {
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
	
		int year = Integer.parseInt(request.getParameter("year"));
		int month = Integer.parseInt(request.getParameter("month"));
		
		//カレンダー構成生成
		ShiftDateGenerator dateGen = new ShiftDateGenerator();
		List<List<String>> calendar = dateGen.getCalendarGrid(year,month);
		
		
		// ログインユーザー情報を取得（セッションから）
		User loginUser = (User) request.getSession().getAttribute("loginUser");
		String userId = loginUser.getUserId();

		// DBからそのユーザーのシフト情報を取得
		ShiftDAO dao = new ShiftDAO();
		List<Shift> shiftlist = dao.getShiftsByUser(userId);

		// JSPで使いやすいように shiftMap を構築（キーは yyyy-MM-dd 形式）
		Map<String, String> shiftMap = new HashMap<>();
		for (Shift s : shiftlist) {
			String date = s.getDate();
			if (date != null && date.length() >= 10) {
				shiftMap.put(date.substring(0, 10).trim(), s.getType());
			}
		}
		request.setAttribute("calendar", calendar);
		request.setAttribute("shiftMap", shiftMap);
		
		String mode = request.getParameter("mode"); // "view" or "input"
		RequestDispatcher dispatcher;

		if ("input".equals(mode)) {
		  dispatcher = request.getRequestDispatcher("WEB-INF/jsp/shiftAddFragment.jsp");
		  System.out.println("mode = " + mode); 

		} else {
		  dispatcher = request.getRequestDispatcher("WEB-INF/jsp/calendarFragment.jsp");
		}
		dispatcher.forward(request, response);

		
//		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/calendarFragment.jsp");
//		dispatcher.forward(request, response);
	}

}
