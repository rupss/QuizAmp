package Users;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public LoginServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");

		ServletContext context = request.getSession().getServletContext();
		HttpSession session = request.getSession();
		
		User user = (User)session.getAttribute("currentUser");
        

        String username = request.getParameter("username");
        String password = request.getParameter("password");


        if (User.isValidLogin(username, password)){
        	context.setAttribute("username", username);
        	user = new User(username);

            request.setAttribute("username", user.getUsername());
            session.setAttribute("currentUser", user);

            RequestDispatcher dispatch = request.getRequestDispatcher("dashboard.jsp");
            dispatch.forward(request, response);
        }else{
        	RequestDispatcher dispatch = request.getRequestDispatcher("tryAgain.jsp");
			dispatch.forward(request, response);
        }
	}

}
