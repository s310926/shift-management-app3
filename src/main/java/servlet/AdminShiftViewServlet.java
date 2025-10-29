package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Shift;
import model.ShiftDAO;
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
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		
		if(loginUser == null || !"admin".equals(loginUser.getRole())) {
			response.sendRedirect("login.jsp");
			return;
		}
		
		ShiftDAO dao = new ShiftDAO();
		List<Shift> shiftList = dao.findAllShifts();
		

		
		Map<String,List<Shift>> shiftMap = new LinkedHashMap<>();
		Set<String> dateSet = new TreeSet<>();
		
		for(Shift shift : shiftList) {
			String userId = shift.getUserId();
			shiftMap.computeIfAbsent(userId,k -> new ArrayList<>()).add(shift);
			dateSet.add(shift.getDate());
		}
		List<String> dateList = new ArrayList<>(dateSet);
		
		request.setAttribute("shiftMap", shiftMap);
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
