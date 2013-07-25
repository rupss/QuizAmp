package Users;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateUserServlet
 */
@WebServlet({ "/UpdateUserServlet", "/update-user" })
public class UpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User currentUser = (User) request.getSession().getAttribute("currentUser");
		if (currentUser == null || !currentUser.isAdmin()) {
			request.getRequestDispatcher("index.jsp").forward(request, response); // send non-admins home
			return;
		}
		String username = request.getParameter("username");
		if(request.getParameter("isDelUser") != null)
		{
			String reinstateUserString = request.getParameter("remove");
			boolean reinstateUser = "true".equals(reinstateUserString);
			if (!reinstateUser) {
				currentUser.reactivateUserAccount(username);
			}
		}
		else{
			User user = new User(username);
			String removeUserString = request.getParameter("remove");
			boolean removeUser = "true".equals(removeUserString);
			if (removeUser) {
				currentUser.removeUserAccount(username);
			} else {
				String isAdminString = request.getParameter("isAdmin");
				boolean isAdmin = "true".equals(isAdminString);
				user.setAdmin(isAdmin);
			}
		}
		request.getRequestDispatcher("admin.jsp?message=" + username + "%20Updated").forward(request, response); // tell user announcement sent
	}

}
