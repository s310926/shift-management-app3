package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.ShiftDateGenerator;

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
		request.setAttribute("calendar", calendar);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/calendarFragment.jsp");
		dispatcher.forward(request, response);
	}

}
