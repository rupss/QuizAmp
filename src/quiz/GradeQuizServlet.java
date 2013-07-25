package quiz;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Users.Achievement;
import Users.User;
import database.MyDB;

/**
 * Servlet implementation class GradeQuizServlet
 */
@WebServlet("/GradeQuizServlet")
public class GradeQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check if  user is logged in
		if (((User)request.getSession().getAttribute("currentUser"))==null) {
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
		else
		{
			long duration = (new Date()).getTime() - Long.parseLong(request.getParameter("duration"));
			int quizId = Integer.parseInt(request.getParameter("quizId"));
			String practiceMode = request.getParameter("practiceMode");
			HashMap<Integer, Integer> questionMap = (HashMap<Integer, Integer>) request.getSession().getAttribute("questionMap");

			boolean pMode = false;
			if(practiceMode != null)
				if (practiceMode.equals("on")) pMode = true;

			Quiz quiz = Quiz.readDB(quizId);
			int numCorrect = 0;
			int questionNumber;
			for (questionNumber = 1; /*nothing*/; questionNumber++) {
				AbstractQuestion question = AbstractQuestion.readDB(quizId, questionNumber);
				if (question == null) break;
				String answer = request.getParameter(question.getInputName());
				if (question.isCorrect(answer))
				{
					numCorrect += 1; // +1 for right answer
					if(pMode)
						questionMap.put(question.getNumber(), questionMap.get(question.getNumber())+1);
				}
			}
			int numberOfQuestions = questionNumber - 1;
			double score = 100 * ((double) numCorrect) / numberOfQuestions;

			//rounds
			
			score = Quiz.roundToTwoDecimalPlaces(score);

			Connection con = MyDB.getConnection();
			User currentUser = (User) request.getSession().getAttribute("currentUser");

			if (!pMode)
			{
				//Check for "I am the Greatest" achievement

				double highestScore = quiz.getTopScore();
				String currentTime = "";
				String username = (String) ((User) request.getSession().getAttribute("currentUser")).getUsername();

				if (score >= highestScore && score != 0) {
					currentUser.awardAchievement(Achievement.I_AM_THE_GREATEST);
				}
				try {
					PreparedStatement stmt = con.prepareStatement("insert into TookQuiz (quizID, username, score, time, duration, practiceMode)values(?, ?, ?, ?, ?, ?);");
					stmt.setInt(1, quizId);
					stmt.setString(2, (String) ((User) request.getSession().getAttribute("currentUser")).getUsername());
					stmt.setDouble(3, score);
					java.util.Date dt = new java.util.Date();
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					currentTime = sdf.format(dt);
					stmt.setString(4, currentTime);
					stmt.setLong(5, duration);
					stmt.setBoolean(6, false);
					stmt.executeUpdate();
					currentUser.deleteChallenges(quizId);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				request.setAttribute("score", score);
				request.setAttribute("duration", duration);
				request.setAttribute("quizName", quiz.getName());
				request.setAttribute("timeTaken", currentTime );
				request.setAttribute("username", username);
				request.setAttribute("quizID", quizId);
				request.setAttribute("quiz", quiz);
				request.setAttribute("quizId", quiz.getQuizId());
				request.getRequestDispatcher("results.jsp").forward(request, response);

				//checking for quiz machine achievement

				currentUser.awardAchievement(Achievement.QUIZ_MACHINE); //this method does the checking necessary



			}
			else
			{
				currentUser.awardAchievement(Achievement.PRACTICE_MAKES_PERFECT); //this method does the checking necessary
				request.getSession().setAttribute("questionMap", questionMap);
				request.getRequestDispatcher("ViewQuiz.jsp?practiceMode=on&id="+quizId).forward(request, response);
			}
		}

	}

}
