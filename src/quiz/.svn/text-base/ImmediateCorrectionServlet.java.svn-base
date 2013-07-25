package quiz;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ImmediateCorrectionServlet.
 * This Servlet receives AJAX requests from quizes and immediately gives
 * feedback on whether or not the answer is correct.
 */
@WebServlet({ "/ImmediateCorrectionServlet", "/immediate-correction" })
public class ImmediateCorrectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int quizId = Integer.parseInt(request.getParameter("quizId"));
		int questionNumber = Integer.parseInt(request.getParameter("order-number"));
		AbstractQuestion question = AbstractQuestion.readDB(quizId, questionNumber);
		String answer = request.getParameter(question.getInputName());
		if (answer == null) answer = "";
		boolean isCorrect = question.isCorrect(answer);
		
		// print out JSON
		// escape answer for JSON
		answer = answer.replace("\\", "\\\\"); // replace \ with \\
		answer = answer.replace("\n", "\\n"); // replace newline with \n
		answer = answer.replace("\r", "\\r"); // replace return with \r
		answer = answer.replace("\t", "\\t"); // replace tab with \t
		answer = answer.replace("\f", "\\f"); // replace feed with \f
		answer = answer.replace("\"", "\\\""); // replace " with \"
		answer = answer.replace("\b", "\\b"); // replace backspace with \b
		answer = answer.replace("/", "\\/"); // replace / with \/
		
		PrintWriter out = response.getWriter();
		out.print("{");
		answer = answer.replace("\\", "\\\\"); // escape \ with \\
		answer = answer.replace("\"", "\\\""); // escape " with \"
		out.print("\"answer\":\"" + answer + "\", ");
		out.print("\"correct\":\"" + isCorrect + "\"");
		out.print("}");
	}

}
