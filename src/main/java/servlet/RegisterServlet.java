package servlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.User;
import model.UserDAO;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/register.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		String name = request.getParameter("name");
		String pass = request.getParameter("pass");
		
//		System.out.println("Servlet: doPost開始");
//		System.out.println("Servlet: userId = " + userId);
		
		 int idNum;
		 try {
		        idNum = Integer.parseInt(userId);
		    } catch (NumberFormatException e) {
		        request.setAttribute("registerError", "ユーザーIDは数字で入力してください");
		        request.setAttribute("userId", userId);
		        request.setAttribute("name", name);
		        request.setAttribute("pass", pass);
		        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/register.jsp");
		        dispatcher.forward(request, response);
		        return;
		    }

//		 int idNum = Integer.parseInt(userId);
	    String role = (idNum < 5000) ? "admin" : "user";
		    
		    

	    User user = new User(userId, name, pass, role);
	    try {
	        UserDAO userDao = new UserDAO();
//	        System.out.println("Servlet: insertUser() 呼び出し前");

	        boolean result = userDao.insertUser(user);
//	        System.out.println("Servlet: insertUser() 呼び出し後、結果 = " + result);

	        if (!result) {
	            request.setAttribute("registerError", "このユーザーIDはすでに登録されています");
	            request.setAttribute("userId", userId);
	            request.setAttribute("name", name);
	            request.setAttribute("pass", pass);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/register.jsp");
	            dispatcher.forward(request, response);
	            return;
	        }

	        request.setAttribute("registerSuccess", "新規登録が完了しました");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
	        dispatcher.forward(request, response);

	    } catch (Exception e) {
//	        System.out.println("Servlet: 例外発生 - " + e.getMessage());
	        e.printStackTrace();
	        request.setAttribute("registerError", "予期せぬエラーが発生しました");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/register.jsp");
	        dispatcher.forward(request, response);
	    }
	}
}


