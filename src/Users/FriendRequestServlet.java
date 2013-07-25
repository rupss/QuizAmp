package Users;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FriendRequestServlet
 */
@WebServlet({ "/FriendRequestServlet", "/friend-request" })
public class FriendRequestServlet extends HttpServlet {
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
		
		String friendUsername = request.getParameter("username");
		User friendUser = new User(friendUsername);
		boolean makeFriends = Boolean.parseBoolean(request.getParameter("makeFriends"));
		
		
		if (makeFriends) { // friendship or request being created
			if (currentUser.hasPendingFriendshipWith(friendUsername)) { // accepting friend request
				currentUser.processFriendRequest(true, friendUsername);
			} else if (friendUser.hasPendingFriendshipWith(currentUser.getUsername())) {
				// do nothing - the current user has already sent a friend request
			} else {
				currentUser.sendFriendRequest(friendUsername);
			}
		} else { // rejecting or terminating friendship
			currentUser.processFriendRequest(false, friendUsername);
		}
		
		out.print("{\"success\": true}"); // send response that it succeeded
	}

}
