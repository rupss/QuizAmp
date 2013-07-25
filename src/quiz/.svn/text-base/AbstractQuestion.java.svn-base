package quiz;

import java.io.StringReader;
import java.io.StringWriter;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamWriter;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import database.MyDB;

/**
 * The super class of all question types.
 * 
 * 
 * To add a new question type, you must create a class which extends AbstractQuestion, and do the following:
 * <ol>
 * <li>Add the class to getQuestionSubclasses() method in this file.</li>
 * <li>In this class, update all if/else if type checks.</li>
 * <li>Implement abstract methods.</li>
 * <li>In your class, implement public static String newQuestionHTML().
 * Note: For input fields, give each a unique name with alphabetic characters only. In this field, add
 * a hidden input with name="type" and value set to the appropriate AbstractQuestion
 * constant <code>QUESTION_*</code>. For example, for ResponseQuestion:
 * <code>"&lt;input type=\"hidden\" name=\"type\" value=\"" + QUESTION_RESPONSE + "\"&gt;"</code>.</li>
 * <li>In your class, implement public static String newAnswerHTML(). Note: For input fields, give each a unique name with alphabetic characters only.</li>
 * <li>In all HTML code, always use double quotes (") for quotes and never use single quotes (').
 * <li>In your class, implement public static String userFiendlyName().</li>
 * <li>In your class, implement static String requestToXML(int number, HttpServletRequest request),
 * which takes parameters from the request and formats the XML to be stored in the database. Make sure
 * to user the escape method for user input.</li>
 * </ol>
 * 
 * @author rglobus
 * @author Jujhaar Singh
 *
 */
public abstract class AbstractQuestion {
	protected int quizId, number;
	protected String type, text;
	
	public static final String QUESTION_RESPONSE = "question-response";
	public static final String QUESTION_BLANK = "fill-in-blank";
	public static final String QUESTION_MULTIPLE_CHOICE = "multiple-choice";
	public static final String QUESTION_PICTURE = "picture-response";
	public static final String QUESTION_MULTIPLE_ANSWER = "multiple-answer";
	
	/**
	 * Returns all the subclasses of Abstract Questions.
	 * @return Returns all types of questions.
	 */
	public static Class<?>[] getQuestionSubclasses() {
		return (Class<?>[]) new Class<?>[]  {PictureQuestion.class, ResponseQuestion.class,
				FillBlankQuestion.class, MultipleChoiceQuestion.class, MultipleAnswerQuestion.class};
	}
	
	/**
	 * The proper way to instantiate a question. This will look at the type
	 * and properly return the right type of question.
	 * <em>Call this instead of calling an AbstractQuestion (or subclass)
	 * constructor.</em><br />
	 * <em>This constructor does not interact with the database at all.</em>
	 * @param quizId
	 * @param number
	 * @param type
	 * @param text
	 * @param answer
	 * @return A subclass of AbstractQuestion
	 */
	public static AbstractQuestion generateQuestion(int quizId, int number,
			String type, String text) {
		AbstractQuestion question;
		if (type.equals(QUESTION_RESPONSE)) question = new ResponseQuestion();
		else if (type.equals(QUESTION_BLANK)) question = new FillBlankQuestion();
		else if (type.equals(QUESTION_MULTIPLE_CHOICE)) question = new MultipleChoiceQuestion();
		else if (type.equals(QUESTION_PICTURE)) question = new PictureQuestion();
		else if (type.equals(QUESTION_MULTIPLE_ANSWER)) question = new MultipleAnswerQuestion();
		else return null;
		question.quizId = quizId;
		question.number = number;
		question.type = type;
		question.text = text;
		return question;
	}
	
	/**
	 * Reads and returns a Question from the database with the provided
	 * quizId and number. If there is no such question or a SQL error,
	 * this method returns null.
	 * @param quizId
	 * @param number
	 * @return the Question with the given parameters or null if none
	 * exists or SQL error
	 */
	public static AbstractQuestion readDB(int quizId, int number) {
		Connection con = MyDB.getConnection();
		try {
			PreparedStatement stmt = con.prepareStatement("select * from Question where quizID = ? and orderNumber = ?");
			stmt.setInt(1, quizId);
			stmt.setInt(2, number);
			ResultSet results = stmt.executeQuery();
			if (!results.first()) return null; // return null if no such Question
			return generateQuestion(quizId, number, results.getString("type"), results.getString("text"));
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * Instantiates a question and writes it to the database. Text is in XML
	 * @param quizId
	 * @param number
	 * @param type
	 * @param text raw XML of question
	 * @return the question created or null if SQL error.
	 */
	static AbstractQuestion createQuestion(int quizId, int number, String type, String text) {
		// Write to database
		Connection con = MyDB.getConnection();
		try {
			PreparedStatement stmt = con.prepareStatement("insert into Question" +
					"(quizID, orderNumber, type, text) values (?, ?, ?, ?);");
			stmt.setInt(1, quizId);
			stmt.setInt(2, number);
			stmt.setString(3, type);
			stmt.setString(4, text);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return generateQuestion(quizId, number, type, text);
	}
	
	/**
	 * Instantiates a question and writes it to the database. Request should
	 * be an HttpServletRequest from creating or editing a quiz.
	 * @param quizId
	 * @param number
	 * @param type
	 * @param request
	 * @return The question which is created or null if SQL error.
	 */
	public static AbstractQuestion createQuestion(int quizId, int number, String type, HttpServletRequest request) {
		// Create the Question in Java
		String text;
		// TODO: below if/else if structure is duplicated code
		if (type.equals(QUESTION_RESPONSE)) text = ResponseQuestion.requestToXML(number, request);
		else if (type.equals(QUESTION_MULTIPLE_CHOICE)) text = MultipleChoiceQuestion.requestToXML(number, request);
		else if (type.equals(QUESTION_BLANK)) text = FillBlankQuestion.requestToXML(number, request);
		else if (type.equals(QUESTION_PICTURE)) text = PictureQuestion.requestToXML(number, request);
		else if (type.equals(QUESTION_MULTIPLE_ANSWER)) text = MultipleAnswerQuestion.requestToXML(number, request);
		else return null;
		
		return createQuestion(quizId, number, type, text);
	}
	
	/**
	 * 
	 * @param answer
	 * @return Returns true iff answer is a correct answer.
	 */
	public abstract boolean isCorrect(String answer);
	
	/**
	 * 
	 * @return An HTML String which can be used to display the question.
	 */
	public abstract String toHTML();
	
	// TODO: javascript
	
	public String toXML() {
		return text;
	}
	
	/**
	 * Returns a normalized DOM Document which is based on the XML text of the question.
	 * @return a DOM document from XML
	 */
	protected Document getXMLDocument() {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		Document doc;
		try {
			DocumentBuilder parser = factory.newDocumentBuilder();
			doc = parser.parse(new InputSource(new StringReader(text)));
			doc.getDocumentElement().normalize();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return doc;
	}
	
	/**
	 * True iff the answer string is in an XML "answer" element
	 * @param answer
	 * @return
	 */
	protected boolean isAnswerInXML(String answer) {
		Document doc = getXMLDocument(); // TODO: if doc is null?
		NodeList answers = doc.getElementsByTagName("answer");
		for (int i = 0; i < answers.getLength(); i++) {
			Node answerNode = answers.item(i);
			if (answerNode.getTextContent().equals(answer)) return true;
		}
		return false;
	}

	/**
	 * @return the quizId
	 */
	public int getQuizId() {
		return quizId;
	}

	/**
	 * @return the number
	 */
	public int getNumber() {
		return number;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	
	/**
	 * 
	 * @return the name attribute of the input field where the user enters
	 * their answer
	 */
	public String getInputName() {
		return "quiz-" + quizId + "-question-" + number;
	}
	
	/**
	 * This method takes in a String and escapes it for XML purposes. It will
	 * escape <, >, and &, but NOT ".
	 * @param str the string to escape
	 * @return an XML-escaped version of str
	 */
	public static String escape(String str) {
		StringWriter stringWriter = new StringWriter();
		try {
			XMLStreamWriter xmlWriter = XMLOutputFactory.newInstance().createXMLStreamWriter(stringWriter);
			xmlWriter.writeCharacters(str); // this escapes the characters
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return stringWriter.toString();
	}
	
}
