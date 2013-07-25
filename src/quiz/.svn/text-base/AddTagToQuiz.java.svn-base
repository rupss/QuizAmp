package quiz;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddTagToQuiz
 */
@WebServlet("/AddTagToQuiz")
public class AddTagToQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTagToQuiz() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tagName = request.getParameter("tagName");
		int quizID = Integer.parseInt(request.getParameter("quizID"));
		Quiz quiz = Quiz.readDB(quizID);
		quiz.addTag(tagName);
		String url = "QuizSummary.jsp?id=" + quizID;
		request.getRequestDispatcher(url).forward(request, response);
	}

}
