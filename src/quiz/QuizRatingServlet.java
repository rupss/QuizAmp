package quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.MyDB;

/**
 * Servlet implementation class QuizRatingServlet
 */
@WebServlet("/QuizRatingServlet")
public class QuizRatingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		String strRating = request.getParameter("rating");
		double rating;
		
        String username = request.getParameter("username");
        int quizID = Integer.parseInt(request.getParameter("quizID"));
        String timeTaken = request.getParameter("timeTaken");

       if (strRating.equals("")){
			rating = 0.0;
		}else{
			rating = Double.parseDouble(request.getParameter("rating"));
		}
        updateTookQuiz(username, quizID, timeTaken, rating);

        response.sendRedirect("index.jsp");


	}
	
	private void updateTookQuiz(String username, int id, String timeTaken, double rating){
		Connection conn = MyDB.getConnection();
		
		try{
			String strSQL = "UPDATE TookQuiz SET rating = ? WHERE username = ? AND time = ? and quizID = ?";
            PreparedStatement stmt = conn.prepareStatement(strSQL);
            
            stmt.setDouble(1, rating);
            stmt.setString(2, username);
            stmt.setString(3, timeTaken);
            stmt.setInt(4, id);

            stmt.executeUpdate();

		}catch(SQLException e){
			e.printStackTrace();
		}
	}

}
