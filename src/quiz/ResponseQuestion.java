package quiz;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.w3c.dom.*;

/**
 * A simple question type with a query and a text answer.
 * @author rglobus
 *
 */
public class ResponseQuestion extends AbstractQuestion {

	@Override
	public String toHTML() {
		Document doc = getXMLDocument();
		if (doc == null) return "<p>ERROR: Error parsing ResponseQuestion to HTML</p>";
		NodeList queries = doc.getElementsByTagName("query");
		String query = queries.item(0).getTextContent();
		String html = "<p class=\"response question\">";
		html += query + "<br />\n";
		html += "<input type=\"text\" name=\"" + getInputName() + "\" />";
		html += "</p>";
		return html;
	}
	
	@Override
	public boolean isCorrect(String answer) {
		return isAnswerInXML(answer);
	}
	
	/**
	 * HTML template for a new ResponseQuestion query (for use in forms).
	 * @return
	 */
	public static String newQuestionHTML() {
		return "<input type=\"hidden\" name=\"type\" value=\"" + QUESTION_RESPONSE + "\"><label>Query:</label> <input name=\"query\" type=\"text\">";
	}
	
	/**
	 * HTML template for a new ResponseQuestion answer (for use in forms).
	 * @return
	 */
	public static String newAnswerHTML() {
		return "<label>Answer:</label> <input name=\"answer\" type=\"text\">";
	}
	
	/**
	 * A user friendly version of the name of this class.
	 * @return
	 */
	public static String userFriendlyName() {
		return "Response Question";
	}

	/**
	 * Takes the information from the request (from creating or editing a quiz)
	 * and converts the information to XML which represents the Response 
	 * Question.
	 * @param number
	 * @param request
	 * @return XML which represents this question
	 */
	static String requestToXML(int number, HttpServletRequest request) {
		// Get values
		String query = request.getParameter("query-" + number);
		query = escape(query);
		List<String> answers = new ArrayList<String>();
		for (int i = 1; /*nothing*/ ; i++) {
			String answer = request.getParameter("answer-" + number + "-" + i);
			if (answer == null) break;
			answer = escape(answer);
			answers.add(answer);
		}
		
		// Construct XML
		String xml = "<question type=\"question-response\">";
		xml += "<query>" + query + "</query>";
		xml += "<answer-list>";
		for (String answer : answers) {
			xml += "<answer>" + answer + "</answer>";
		}
		xml += "</answer-list>";
		xml += "</question>";
		return xml;
	}

}
