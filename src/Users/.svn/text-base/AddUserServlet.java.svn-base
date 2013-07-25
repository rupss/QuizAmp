package Users;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AddUserServlet
 */
@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddUserServlet() {
        super();
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
        
//        ServletContext context = request.getSession().getServletContext();
        HttpSession session = request.getSession();
        
        User user = (User)session.getAttribute("currentUser");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        //Attempt to add user
        if (User.userExists(username)){
            RequestDispatcher dispatch = request.getRequestDispatcher("accountInUse.jsp");
            dispatch.forward(request, response);
        }else{
            //add the new user and redirect to the login page!
            user = new User();
             RequestDispatcher dispatch2 = null;
            if (user.addUser(username, password)){
                session.setAttribute("currentUser", user);
                dispatch2 = request.getRequestDispatcher("dashboard.jsp");
                user.addAllAnnouncements();
                dispatch2.forward(request, response);
            }else{
                dispatch2 = request.getRequestDispatcher("accountInUse.jsp");
                dispatch2.forward(request, response);
            }
        }
	}

}
