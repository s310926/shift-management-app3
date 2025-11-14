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
import jakarta.servlet.http.HttpSession;

import model.Shift;
import model.ShiftDAO;
import model.ShiftDateGenerator;
import model.User;

/**
 * Servlet implementation class AdminShiftViewServlet
 */
@WebServlet("/AdminShiftViewServlet")
public class AdminShiftViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminShiftViewServlet() {
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
		
		request.setAttribute("saved", request.getParameter("saved"));
		
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		
		if(loginUser == null || !"admin".equals(loginUser.getRole())) {
			response.sendRedirect("login.jsp");
			return;
		}
		LocalDate now = LocalDate.now();
		int year = now.getYear();
		int month = now.getMonthValue();
		
		
		ShiftDAO dao = new ShiftDAO();
//		List<Shift> shiftList = dao.findAllShifts();
		Map<String, List<Shift>> shiftMap = dao.getShiftMapForMonth(year, month);
		Map<String,String>userNameMap = dao.getUserNameMap();
		List<String> dateList = new ShiftDateGenerator().getDates(year, month);
		
		

		request.setAttribute("year", year);
		request.setAttribute("month", month);
		
		
		request.setAttribute("shiftMap", shiftMap);
		request.setAttribute("userNameMap", userNameMap);
		request.setAttribute("dateList", dateList);
		
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/adminshiftview.jsp");
		dispatcher.forward(request, response);
		
		}
		
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
