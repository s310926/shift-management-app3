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
import model.UserDAO;

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
		HttpSession session = request.getSession();
	    String loginError = (String) session.getAttribute("loginError");
	    if (loginError != null) {
	        request.setAttribute("loginError", loginError);
	        session.removeAttribute("loginError");
	    }
	    String success = (String)session.getAttribute("registerSuccess");
	    if(success != null) {
	    	request.setAttribute("registerSuccess", success);
	    	session.removeAttribute("registerSuccess");
	    }

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
		
		UserDAO dao = new UserDAO();
		User user = dao.findByIdAndPassword(userId,name, pass);
		
		if(user == null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginError", "ユーザー情報が一致しません。新規登録はお済みですか？");
			response.sendRedirect("LoginServlet");
			return;
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("loginUser",user);
		
		//管理者か一般ユーザーか
		
		 if ("admin".equals(user.getRole())) {
		        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/admin.jsp");
		        dispatcher.forward(request, response);
		    } else {
		        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/select.jsp");
		        dispatcher.forward(request, response);
		    }
		}

	
}
