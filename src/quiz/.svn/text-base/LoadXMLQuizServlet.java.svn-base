package quiz;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Users.User;

/**
 * Servlet implementation class LoadXMLQuizServlet
 */
@WebServlet({ "/LoadXMLQuizServlet", "/load-xml-quiz" })
public class LoadXMLQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User currentUser = (User) request.getSession().getAttribute("currentUser");
		if (currentUser == null) { // make them log in
			response.sendRedirect("index.jsp");
			return;
		}
		
		String xml = request.getParameter("xml");
		Quiz quiz = Quiz.createQuiz(xml, currentUser);
		if (quiz == null) { // there was an error
			response.sendRedirect("load-xml-quiz.jsp");
			return;
		}
		response.sendRedirect("QuizSummary.jsp?id=" + quiz.getQuizId());
	}

}
