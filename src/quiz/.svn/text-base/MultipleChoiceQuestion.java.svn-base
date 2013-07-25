package quiz;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
/**
 * This class represents the mutliple choice question type, and contains the method to create the html
 * @author Jujhaar Singh
 *
 */
public class MultipleChoiceQuestion extends AbstractQuestion {

	@Override
	public String toHTML() {
		Document doc = getXMLDocument();
		if (doc == null) return "<p>ERROR: Error parsing MultipleChoiceQuestion to HTML</p>";
		NodeList queryText = doc.getElementsByTagName("query");
		String query = queryText.item(0).getTextContent();
		String html = "<p class=\"multiple choice question\">";
		html += query + "<br>";
		NodeList options = doc.getElementsByTagName("option");
		List<Integer> indices = new ArrayList<Integer>();
		// shuffle the multiple choice questions
		for (int i = 0; i < options.getLength(); i++) {
			indices.add(i);
		}
		Collections.shuffle(indices);
		for (int i : indices)
		{
			String currOption = options.item(i).getTextContent();
			html += "<input type=\"radio\" name=\"" + getInputName() + "\" value=\"" + currOption + "\">" +
					currOption + "<br>";
		}
		html += "</p>";
		return html;
	}

	public static String newQuestionHTML() {
		return "<input type=\"hidden\" name=\"type\" value=\"" + QUESTION_MULTIPLE_CHOICE + "\">" + 
				"<label>Query:</label> <input name=\"query\" type=\"text\" /><br />" +
				"<label>Correct Answer:</label> <input name=\"correctAnswer\" type=\"text\" /><br />";
	}

	public static String newAnswerHTML() {
		return "<label>Incorrect Answer:</label><input name=\"incorrectAnswer\" type=\"text\" />";
	}

	public static String userFriendlyName() {
		return "Multiple Choice Question";
	}

	static String requestToXML(int number, HttpServletRequest request) {
		// Get parameters
		String query = request.getParameter("query-" + number);
		query = escape(query);
		String correctAnswer = request.getParameter("correctAnswer-" + number);
		correctAnswer = escape(correctAnswer);
		List<String> incorrectAnswers = new ArrayList<String>();
		for (int i = 1; /*nothing*/; i++) {
			String incorrectAnswer = request.getParameter("incorrectAnswer-" + number + "-" + i);
			if (incorrectAnswer == null) break;
			incorrectAnswer = escape(incorrectAnswer);
			incorrectAnswers.add(incorrectAnswer);
		}

		// Construct XML
		String xml = "<question type=\"multiple-choice\">";
		xml += "<query>" + query + "</query>";
		xml += "<option answer=\"answer\">" + correctAnswer + "</option>";
		for (String incorrectAnswer : incorrectAnswers) {
			xml += "<option>" + incorrectAnswer + "</option>";
		}
		xml += "</question>";
		return xml;
	}

	@Override
	public boolean isCorrect(String answer) {
		if (answer==null) return false;
		Document doc = getXMLDocument(); // TODO: if doc is null?
		NodeList options = doc.getElementsByTagName("option");
		for (int i = 0; i < options.getLength(); i++) {
			Node optionNode = options.item(i);
			NamedNodeMap nnmap = optionNode.getAttributes();
			if (nnmap.item(0) != null)
			{
				String isAnswer = nnmap.item(0).getTextContent();
				if(isAnswer != null)
				{
					String correctAnswer = optionNode.getTextContent();
						if(answer.equals(correctAnswer)) return true;
				}
			}
		}
		return false;
	}

}
