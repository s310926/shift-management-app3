package servlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.User;

/**
 * Servlet implementation class MenuServlet
 */
@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MenuServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		User loginUser = (User)request.getSession().getAttribute("loginUser");
		if(loginUser == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		request.setAttribute("loginUser",loginUser);

		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/select.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		User loginUser = (User)request.getSession().getAttribute("loginUser");
		if(loginUser == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		request.setAttribute("loginUser",loginUser);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/jsp/select.jsp");
		dispatcher.forward(request, response);
	}

}
