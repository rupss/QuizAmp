package quiz;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

/**
 * A question type with pretext, a blank for user input, and posttext
 * @author Jujhaar Singh
 *
 */
public class FillBlankQuestion extends AbstractQuestion {

	/**
	 * create the html rendition for fill in the blank questions
	 * @return the html for this question
	 */
	@Override
	public String toHTML() 
	{
		Document doc = getXMLDocument();
		if (doc == null) return "<p>ERROR: Error parsing FillBlankQuestion to HTML</p>";
		NodeList preText = doc.getElementsByTagName("pre");
		NodeList postText = doc.getElementsByTagName("post");
		String post = postText.item(0).getTextContent();
		String pre = preText.item(0).getTextContent();
		String html = "<p class=\"blank question\">";
		html += pre;
		html += "<input type=\"text\" name=\"" + getInputName() + "\" />";
		html += post;
		html += "</p>";
		return html;
	}
	
	@Override
	public boolean isCorrect(String answer) {
		return isAnswerInXML(answer);
	}
	/**
	 * HTML template for a new ResponseQuestion query (for use in forms).
	 * @return the string of query pieces
	 */
	public static String newQuestionHTML()
	{
		return "<input type=\"hidden\" name=\"type\" value=\"" + QUESTION_BLANK + "\">"+
				"<label>1st half:</label> <input name=\"pre\" type=\"text\"><br><label>2nd half:</label><input name=\"post\" type=\"text\">";
	}
	/**
	 * HTML template for a new ResponseQuestion answer (for use in forms).
	 * @return the format for an answer
	 */
	public static String newAnswerHTML() {
		return "<label>Answer:</label> <input name=\"answer\" type=\"text\">";
	}
	/**
	 * A user friendly version of the name of this class.
	 * @return a name
	 */
	public static String userFriendlyName() {
		return "Fill in the Blank Question";
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
		String pre = request.getParameter("pre-" + number);
		pre = escape(pre);
		String post = request.getParameter("post-" + number);
		post = escape(post);
		List<String> answers = new ArrayList<String>();
		for (int i = 1; /*nothing*/ ; i++) {
			String answer = request.getParameter("answer-" + number + "-" + i);
			if (answer == null) break;
			answer = escape(answer);
			answers.add(answer);
		}
		// Construct XML
		String xml = "<question type=\"fill-in-blank\">";
		xml += "<pre>" + pre + "</pre>";
		xml += "<blank></blank>";
		xml += "<post>" + post + "</post>";
		xml += "<answer-list>";
		for (String answer : answers) {
			xml += "<answer>" + answer + "</answer>";
		}
		xml += "</answer-list>";
		xml += "</question>";
		return xml;
	}

}
