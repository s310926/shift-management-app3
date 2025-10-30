package servlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userId = request.getParameter("userId");
		String name = request.getParameter("name");
		String pass = request.getParameter("pass");
		
		int idNum = Integer.parseInt(userId);
	    String role = (idNum < 5000) ? "admin" : "user";

		//ユーザー情報をセッションに保存
		User user = new User(userId,name,pass,role);
		HttpSession session = request.getSession();
		session.setAttribute("loginUser",user);
		
		//管理者か一般ユーザーか
		
		if(idNum < 5000) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/admin.jsp");
		    dispatcher.forward(request, response);

		}else {
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/select.jsp");
		dispatcher.forward(request, response);}

	}
	
}
