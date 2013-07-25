package Users;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class sendMessageServlet
 */
@WebServlet("/sendMessageServlet")
public class sendMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public sendMessageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("to");
		String type = request.getParameter("messageType");
		if (!User.searchForUser(name)) {
			String url = "UserNotFound.jsp";
			request.getRequestDispatcher(url).forward(request, response);
		} else if (type.equals("note")) {
			String url = "sendNote.jsp";
			request.getRequestDispatcher(url).forward(request, response);
		} else {
			String url = "sendChallenge.jsp";
			request.getRequestDispatcher(url).forward(request, response);
		}
	}

}
