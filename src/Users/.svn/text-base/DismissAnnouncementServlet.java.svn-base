package Users;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DismissAnnouncementServlet
 */
@WebServlet({ "/DismissAnnouncementServlet", "/dismiss-announcement" })
public class DismissAnnouncementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		User currentUser = (User) request.getSession().getAttribute("currentUser");
		if (currentUser == null) { // make them log in
			out.print("{\"success\": false, \"href\": \"index.jsp\"}"); // tell them to log in
			return;
		}
		
		int announcementId = Integer.parseInt(request.getParameter("announcementId"));
		boolean success = currentUser.dismissAnnouncement(announcementId);
		out.print("{\"success\":" + success + "}"); // send response that it succeeded
	}

}
