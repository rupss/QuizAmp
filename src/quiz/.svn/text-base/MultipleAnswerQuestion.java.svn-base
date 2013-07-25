package quiz;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

// Note that answers in answer list are required, NOT synonymous
// join answers with \n since \n can't go in input text
public class MultipleAnswerQuestion extends AbstractQuestion {

	@Override
	public boolean isCorrect(String answer) {
		if (answer == null) return false;
		Document doc = getXMLDocument(); // TODO: if null?
		Element answerList = (Element) doc.getElementsByTagName("answer-list").item(0);
		boolean ordered = "true".equals(answerList.getAttribute("ordered")); // default false
		NodeList answerNodes = doc.getElementsByTagName("answer");
		if (ordered) { // if ordered, recreate correct answer string and compare line by line
			String correctAnswer = "";
			for (int i = 0; i < answerNodes.getLength(); i++) {
				if (i > 0) correctAnswer += "\n";
				correctAnswer += answerNodes.item(i).getTextContent();
			}
			BufferedReader answerReader = new BufferedReader(new StringReader(answer));
			BufferedReader correctReader = new BufferedReader(new StringReader(correctAnswer));
			while (true) {
				try {
					String answerLine = answerReader.readLine();
					String correctLine = correctReader.readLine();
					if (answerLine == null && correctLine == null) return true; // both done
					if (answerLine == null || correctLine == null) return false; // one finished early
					if (!answerLine.equals(correctLine)) return false;
				} catch (IOException e) {
					e.printStackTrace();
					return false;
				}
			}
		} else { // otherwise get set of answers submitted, see if each is in answer-list
			BufferedReader br = new BufferedReader(new StringReader(answer));
			Set<String> answers = new HashSet<String>(); // use Set to avoid duplicate Strings
			String line;
			try {
				while ((line = br.readLine()) != null) {
					answers.add(line);
				}
			} catch (IOException e) {
				e.printStackTrace();
				return false;
			}
			if (answers.size() != answerNodes.getLength()) return false;
			for (String currAnswer : answers) {
				if (!isAnswerInXML(currAnswer)) return false;
			}
			return true;
		}
	}

	@Override
	public String toHTML() {
		// get values
		Document doc = getXMLDocument();
		if (doc == null) return "<p>ERROR: Error parsing MultipleAnswerQuestion to HTML</p>";
		String query = doc.getElementsByTagName("query").item(0).getTextContent();
		int numAnswers = doc.getElementsByTagName("answer").getLength();
		
		// basic HTML for the question
		String html = "<p class=\"multiple-answer question\">";
		html += query + "<br />\n";
		for (int i = 0; i < numAnswers; i++) {
			html += "<input type=\"text\" data=\"" + getInputName() + "\" onkeyup=\"multiAnswerUpdate('" + getInputName() + "')\" /><br />\n";
		}
		html += "<input type=\"hidden\" name=\"" + getInputName() + "\" />\n"; // the actual answer
		html += "</p>";
		
		// write the javascript to maniuplate the hidden answer input field
		String js = "<script type=\"text/javascript\">\n";
		js += "if (window.multiAnswerUpdate === undefined) {\n";
		js += "multiAnswerUpdate = function(name) {\n";
		js += "var hiddenField = $('[name=' + name + ']');\n" +
			  "var answers = '';\n" +
			  "$('[data=' + name + ']').each(function() {\n" +
			  		"if (answers != '') answers += '\\n';\n" + // join answers with \n
			  		"answers += $(this).val();\n" +
			  "});\n" + // close each
			  "hiddenField.val(answers);\n";
		js += "};\n"; // close function
		js += "}\n"; // close if block
		js += "</script>";
		return html + js;
	}
	
	public static String newQuestionHTML() {
		return "<input type=\"hidden\" name=\"type\" value=\"" + QUESTION_MULTIPLE_ANSWER + "\">" +
				"<label>Query:</label> <input name=\"query\" type=\"text\"> <br />" +
				"<label>Answer Order Matters:</label> <input name=\"ordered\" type=\"checkbox\" value=\"true\"> <br />" +
				"<small>Note: All answer below will be required, <em>not</em> synonymous.</small>";
	}
	
	public static String newAnswerHTML() {
		return "<label>Answer:</label> <input name=\"answer\" type=\"text\" />";
	}
	
	public static String userFriendlyName() {
		return "Multiple-Answer Question";
	}

	public static String requestToXML(int number, HttpServletRequest request) {
		// Get values
		String query = request.getParameter("query-" + number);
		query = escape(query);
		boolean ordered = "true".equals(request.getParameter("ordered-" + number));
		List<String> answers = new ArrayList<String>();
		for (int i = 1; /*nothing*/; i++) {
			String answer = request.getParameter("answer-" + number + "-" + i);
			if (answer == null) break;
			answer = escape(answer);
			answers.add(answer);
		}
		
		// Construct XML
		String xml = "<question type=\"" + QUESTION_MULTIPLE_ANSWER + "\">";
		xml += "<query>" + query + "</query>";
		xml += "<answer-list ordered=\"" + ordered + "\">";
		for (String answer : answers) {
			xml += "<answer>" + answer + "</answer>";
		}
		xml += "</answer-list>";
		xml += "</question>";
		return xml;
	}
	
	

}
