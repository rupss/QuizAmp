package Users;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CreateAnnouncementServlet
 */
@WebServlet({ "/CreateAnnouncementServlet", "/create-announcement" })
public class CreateAnnouncementServlet extends HttpServlet {
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
		String title = request.getParameter("title");
		String text = request.getParameter("text");
		currentUser.createAnnouncement(title, text);
		request.getRequestDispatcher("admin.jsp?message=Announcement%20Sent").forward(request, response); // tell user announcement sent
	}

}
