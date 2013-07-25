package quiz;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Users.User;

/**
 * Servlet implementation class UpdateQuizServelet
 */
@WebServlet("/update-quiz")
public class UpdateQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// System.out.println("Clicked a button");
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null || !currentUser.isAdmin()) {
        	String url = "dashboard.jsp?id=" + currentUser.getUsername();
            request.getRequestDispatcher("\"" + url + "\"").forward(request, response); // send non-admins home
            return;
        }
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        String removeQuizString = request.getParameter("removeQuiz");
        boolean removeQuiz = "true".equals(removeQuizString);
        if(removeQuiz){
        	User.removeQuiz(quizId);
        	 request.getRequestDispatcher("admin.jsp?message=Quiz# " + quizId + "%20Removed").forward(request, response); // tell quiz removed
        }
        String clearHistoryString = request.getParameter("clearHistory");
        boolean clearHistory = "true".equals(clearHistoryString);
        if (clearHistory) {
        	User.clearQuizHistory(quizId);
        	 request.getRequestDispatcher("admin.jsp?message=Quiz# " + quizId + "%20History%20Cleared").forward(request, response); // tell quiz history gone
        }
        System.out.println(quizId);
	}

}
