package quiz;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class resultsWithFriend
 */
@WebServlet("/resultsWithFriend")
public class resultsWithFriend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public resultsWithFriend() {
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
		System.out.println("New" + request.getParameter("quizId"));
		int quizId = Integer.parseInt(request.getParameter("quizId"));
		long duration = Long.parseLong(request.getParameter("duration"));
		double score = Double.parseDouble(request.getParameter("score"));
		String friend = request.getParameter("friendSelect");
		System.out.println("Friend select" + request.getParameter("friendSelect"));
		Quiz quiz = Quiz.readDB(quizId);
		
		request.setAttribute("score", score);
		request.setAttribute("quizName", quiz.getName());
		request.setAttribute("duration", duration);
		request.setAttribute("quiz", quiz);
		request.setAttribute("quizId", quizId);
		request.setAttribute("friend", friend);
		request.getRequestDispatcher("resultWithFriend.jsp").forward(request, response);
		
	
	}

}
