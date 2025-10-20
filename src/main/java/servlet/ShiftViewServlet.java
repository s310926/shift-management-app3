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
 * Servlet implementation class ShiftView
 */
@WebServlet("/ShiftViewServlet")
public class ShiftViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShiftViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		User loginUser = (User)request.getSession().getAttribute("loginUser");
		String userId = loginUser.getId();
		
		ShiftDAO dao = new ShiftDAO();
		List<Shift> shiftlist = dao.getShiftsByUser(userId);
		request.setAttribute("shiftList", shiftlist);
		
//		カレンダー構成生成
		ShiftDateGenerator dateGen = new ShiftDateGenerator();
		List<List<String>> calendar = dateGen.getCalendarGrid(2025,10);
		request.setAttribute("calendar", calendar);
		
		
//		JSPで使いやすいようにshiftMap作成
		Map<String,String> shiftMap = new HashMap();
		for(Shift s : shiftlist ) {
			shiftMap.put(s.getDate(), s.getType());

		}
		request.setAttribute("shiftMap",shiftMap);
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/shiftview.jsp");
		dispatcher.forward(request, response);
		
		
	}

//	private void getShiftsByUser(String userId) {
		// TODO 自動生成されたメソッド・スタブ
		
//	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		
		
	}

}
