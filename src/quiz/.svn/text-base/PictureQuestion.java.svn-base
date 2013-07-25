package quiz;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.w3c.dom.*;

/**
 * A question type with a picture and a text response.
 * @author rglobus
 *
 */
public class PictureQuestion extends AbstractQuestion {

	@Override
	public String toHTML() {
		Document doc = getXMLDocument();
		if (doc == null) return "<p>ERROR: Error parsing PictureQuestion to HTML</p>";
		NodeList imageLocations = doc.getElementsByTagName("image-location");
		String imageURL = imageLocations.item(0).getTextContent();
		String html = "<p class=\"picture question\">";
		html += "<img src=\"" + imageURL + "\" alt=\"Question Image\" /><br />\n";
		html += "<input type=\"text\" name=\"" + getInputName() + "\" />";
		html += "</p>";
		return html;
	}
	
	@Override
	public boolean isCorrect(String answer) {
		return isAnswerInXML(answer);
	}
	
	/**
	 * HTML template for a new PictureQuestion query (for use in forms).
	 * @return
	 */
	public static String newQuestionHTML() {
		return "<input type=\"hidden\" name=\"type\" value=\"" + QUESTION_PICTURE + "\"><label>Image URL:</label> <input name=\"url\" type=\"text\">";
	}
	
	/**
	 * HTML template for a new AnswerQuestion answer (for use in forms).
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
		return "Picture Question";
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
		String imageURL = request.getParameter("url-" + number);
		imageURL = escape(imageURL);
		List<String> answers = new ArrayList<String>();
		for (int i = 1; /*nothing*/ ; i++) {
			String answer = request.getParameter("answer-" + number + "-" + i);
			if (answer == null) break;
			answer = escape(answer);
			answers.add(answer);
		}
		
		// Construct XML
		String xml = "<question type=\"picture-response\">";
		xml += "<image-location>" + imageURL + "</image-location>";
		xml += "<answer-list>";
		for (String answer : answers) {
			xml += "<answer>" + answer + "</answer>";
		}
		xml += "</answer-list>";
		xml += "</question>";
		return xml;
	}

}
