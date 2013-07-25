package quiz;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Users.User;

/**
 * Servlet implementation class CreateQuizServlet
 */
@WebServlet({ "/CreateQuizServlet", "/create-quiz" })
public class CreateQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// create quiz first
		User currentUser = (User) request.getSession().getAttribute("currentUser");
		if (currentUser == null) { // make them log in
			request.getRequestDispatcher("index.jsp").forward(request, response);
			return;
		}
		
		String secondsPerQuestionString = request.getParameter("seconds-per-question");
		int secondsPerQuestion;
		if (secondsPerQuestionString == null || "".equals(secondsPerQuestionString)) secondsPerQuestion = 0;
		else secondsPerQuestion = Integer.parseInt(secondsPerQuestionString);
		Quiz quiz = Quiz.createQuiz(currentUser.getUsername(),
				new Timestamp(new Date().getTime()), request.getParameter("title"), request.getParameter("description"),
				Boolean.parseBoolean(request.getParameter("random-order")),
				Boolean.parseBoolean(request.getParameter("multiple-pages")),
				Boolean.parseBoolean(request.getParameter("immediate-correction")),
				Boolean.parseBoolean(request.getParameter("practice-mode")),
				secondsPerQuestion);
		
		currentUser.awardAchievement("Amateur Author");
		// now create the questions
		//int numberQuestions = Integer.parseInt(request.getParameter("number-of-questions"));
		for (int questionNumber = 1; /*nothing*/; questionNumber++) {
			String type = request.getParameter("type-" + questionNumber);
			if (type == null) break;
			AbstractQuestion.createQuestion(quiz.getQuizId(), questionNumber, type, request);
		}
		// forward to quiz summary
		request.getRequestDispatcher("QuizSummary.jsp?id=" + quiz.getQuizId()).forward(request, response);
	}

}
