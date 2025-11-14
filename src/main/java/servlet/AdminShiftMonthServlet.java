package servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.DateGenerator;
import model.Shift;
import model.ShiftDAO;

/**
 * Servlet implementation class AdminShiftMonthServlet
 */
@WebServlet("/AdminShiftMonthServlet")
public class AdminShiftMonthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminShiftMonthServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String editParam = request.getParameter("edit");
		boolean editMode = "true".equals(editParam);
		request.setAttribute("editMode", editMode);
		
		int year, month;
		try {
		    year = Integer.parseInt(request.getParameter("year"));
		    month = Integer.parseInt(request.getParameter("month"));
		} catch (NumberFormatException | NullPointerException e) {
		    LocalDate now = LocalDate.now();
		    year = now.getYear();
		    month = now.getMonthValue();
		}

		ShiftDAO dao = new ShiftDAO();

		List<String> dateList = DateGenerator.getDatesForMonth(year, month);
		Map<String, List<Shift>> shiftMap = dao.getShiftMapForMonth(year, month);
		Map<String,String> userNameMap = dao.getUserNameMap();
//test
		System.out.println("year = " + year + ", month = " + month);
		System.out.println("editMode = " + editMode);
//		test
		request.setAttribute("year", year);
		request.setAttribute("month", month);
		request.setAttribute("dateList", dateList);
		request.setAttribute("shiftMap", shiftMap);
		request.setAttribute("editMode", editMode);
		request.setAttribute("userNameMap",userNameMap);

		response.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/adminshiftmonth.jsp");
		dispatcher.include(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
