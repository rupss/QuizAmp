package quiz;

import java.io.StringReader;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.StringTokenizer;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import Users.User;
import database.MyDB;

public class Quiz {
	private int quizId;
	private double rating;
	private String username;
	private Timestamp timeCreated;
	private String name, description;
	private boolean randomOrder, multiplePages, immediateCorrection, isPracticeMode;
	private int secondsPerQuestion;

	public static final int TIME_LIMIT_IN_MINUTES = 60*24; // 1 day

	/**
	 * Create a Question object. Note that this method does not interact with
	 * the database at all.
	 * @param username
	 * @param timeCreated
	 * @param name
	 * @param description
	 * @param randomOrder
	 * @param multiplePages
	 * @param immediateCorrection
	 * @param isPracticeMode
	 */
	public Quiz(int quizId, String username, Timestamp timeCreated, String name,
			String description, boolean randomOrder, boolean multiplePages,
			boolean immediateCorrection, boolean isPracticeMode, int secondsPerQuestion) {
		this.quizId = quizId;
		this.username = username;
		this.timeCreated = timeCreated;
		this.name = name;
		this.description = description;
		this.randomOrder = randomOrder;
		this.multiplePages = multiplePages;
		this.immediateCorrection = immediateCorrection;
		this.isPracticeMode = isPracticeMode;
		this.rating = getQuizRating();
		//this.setCategory("Uncategorized");
		this.secondsPerQuestion = secondsPerQuestion;
	}

	/**
	 * Creates a Quiz, writes it to the database, and returns the newly created
	 * Quiz. Returns null if there is a SQL problem.
	 * @param username
	 * @param timeCreated
	 * @param name
	 * @param description
	 * @param randomOrder
	 * @param multiplePages
	 * @param immediateCorrection
	 * @param isPracticeMode
	 * @return
	 */
	public static Quiz createQuiz(String username, Timestamp timeCreated, String name,
			String description, boolean randomOrder, boolean multiplePages,
			boolean immediateCorrection, boolean isPracticeMode, int secondsPerQuestion) {
		// Create a quiz with ID -1, then set ID to proper value later
		Quiz quiz = new Quiz(-1, username, timeCreated, name, description,
				randomOrder, multiplePages, immediateCorrection, isPracticeMode, secondsPerQuestion);
		Connection con = MyDB.getConnection();
		try {
			PreparedStatement stmt = con.prepareStatement(
					"insert into Quiz (username, timeCreated, name, " +
							"description, randomOrder, multiplePages, immediateCorrection, " +
							"practiceMode, secondsPerQuestion) values (?, ?, ?, ?, ?, ?, ?, ?, ?);",
							Statement.RETURN_GENERATED_KEYS);
			// set the parameters for the query
			stmt.setString(1, username);
			//Timestamp date = new Timestamp(timeCreated.getTime()); // convert to SQL date
			stmt.setTimestamp(2, timeCreated);
			stmt.setString(3, name);
			stmt.setString(4, description);
			stmt.setBoolean(5, randomOrder);
			stmt.setBoolean(6, multiplePages);
			stmt.setBoolean(7, immediateCorrection);
			stmt.setBoolean(8, isPracticeMode);
			stmt.setInt(9, secondsPerQuestion);
			stmt.executeUpdate();
			ResultSet results = stmt.getGeneratedKeys();
			results.first();
			quiz.quizId = results.getInt(1); // set quizID to proper value
			return quiz;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * Creates and returns a Quiz from the XML string.
	 * @param xml
	 * @param username the creator
	 * @return the quiz created or null if there was an error (SQL or XML)
	 */
	public static Quiz createQuiz(String xml, User user) {
		// TODO category not implemented
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		Document doc;
		try {
			DocumentBuilder parser = factory.newDocumentBuilder();
			doc = parser.parse(new InputSource(new StringReader(xml)));
			doc.getDocumentElement().normalize();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		// create quiz
		Timestamp timeCreated = new Timestamp((new Date()).getTime());
		String name = doc.getElementsByTagName("title").item(0).getTextContent();
		String description = doc.getElementsByTagName("description").item(0).getTextContent();
		Element quizElem = (Element) doc.getElementsByTagName("quiz").item(0);
		boolean randomOrder = !quizElem.getAttribute("random").equals("false"); // default true
		boolean onePage = !quizElem.getAttribute("one-page").equals("false"); // default true
		boolean multiplePages = !onePage;
		boolean immediateCorrection = quizElem.getAttribute("immediate-correction").equals("true"); // default false
		boolean isPracticeMode = !quizElem.getAttribute("practice-mode").equals("false"); // default true
		String secondsPerQuestionString = quizElem.getAttribute("seconds-per-question");
		int secondsPerQuestion;
		if ("".equals(secondsPerQuestionString)) secondsPerQuestion = 0;
		else secondsPerQuestion = Integer.parseInt(secondsPerQuestionString);
		
		Quiz quiz = createQuiz(user.getUsername(), timeCreated, name, description, randomOrder,
				multiplePages, immediateCorrection, isPracticeMode, secondsPerQuestion);
		
		// create questions
		NodeList questions = doc.getElementsByTagName("question");
		for (int i = 0; i < questions.getLength(); i++) {
			Element question = (Element) questions.item(i);
			int quizId = quiz.getQuizId();
			int number = i + 1;
			String type = question.getAttribute("type");
			// convert XML to String - surprisingly complicated
			// source of transformation:
			// http://tech.chitgoks.com/2010/05/06/convert-org-w3c-dom-node-to-string-using-java/
			try {
				Transformer transformer = TransformerFactory.newInstance().newTransformer();
				transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
				StringWriter stringWriter = new StringWriter();
				transformer.transform(new DOMSource(question), new StreamResult(stringWriter));
				String questionXML = stringWriter.toString();
				AbstractQuestion.createQuestion(quizId, number, type, questionXML);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return quiz;
	}
	
	/**
	 * Returns a Quiz from the database with the given quizId.
	 * @param quizId
	 * @return the quiz. Returns <code>null</code> if there is a SQL error
	 * or no Quiz has the given quizId
	 */
	public static Quiz readDB(int quizId) {
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery("select * from Quiz where quizID = " + quizId + ";");
			if (!results.next()) return null; // quiz is not in table
			return new Quiz(quizId,
					results.getString("username"),
					results.getTimestamp("timeCreated"),
					results.getString("name"),
					results.getString("description"),
					results.getBoolean("randomOrder"),
					results.getBoolean("multiplePages"),
					results.getBoolean("immediateCorrection"),
					results.getBoolean("practiceMode"),
					results.getInt("secondsPerQuestion"));
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * @return the quizId
	 */
	public int getQuizId() {
		return quizId;
	}

	/**
	* Retrieves the rating for the current quiz
	* @return int rating. 0 if no ratings yet
	* @author lennon
	*/
	public double getQuizRating(){
		// calculate the quiz rating
		return calculateRating();
	}

	/*
	calculates the rating from took quiz. Returns 0 if no ratings yet.
	*/
	private double calculateRating(){
		String strSQL = "Select rating from TookQuiz where quizID = ? and rating is not NULL"; // ignore quizzes with no rating
		double totalReviews = 0;
		double sumRatings = 0;
		
		Connection conn = MyDB.getConnection();
		try{
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setInt(1, this.quizId);

			ResultSet rs =stmt.executeQuery();

			while(rs.next()){
				totalReviews += 1;
				sumRatings += rs.getDouble("rating");
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		if (totalReviews == 0) return 0;
		double unrounded = (sumRatings/totalReviews);	
		return Quiz.roundToTwoDecimalPlaces(unrounded);
	}

	public void setQuizRating(){
		
	}

	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * @return the timeCreated
	 */
	public Date getTimeCreated() {
		return timeCreated;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @return the randomOrder
	 */
	public boolean isRandomOrder() {
		return randomOrder;
	}

	/**
	 * @return the multiplePages
	 */
	public boolean isMultiplePages() {
		return multiplePages;
	}

	/**
	 * @return the immediateCorrection
	 */
	public boolean isImmediateCorrection() {
		return immediateCorrection;
	}

	/**
	 * @return the isPracticeMode
	 */
	public boolean isPracticeMode() {
		return isPracticeMode;
	}
	
	/**
	 * 
	 * @return the seconds allocated for each question. 0 if unlimited time per question
	 */
	public int getSecondsPerQuestion() {
		return secondsPerQuestion;
	}

	/**
	 * Returns an array of QuizTaken objects for this quiz in reverse
	 * chronological order from all of time.
	 * @return all quiz history of this quiz
	 */
	public QuizTaken[] getAllHistory() {
		return getQuizTakens(
				"select * from TookQuiz where quizId = " + quizId +
				" order by time desc;"
				);
	}

	/**
	 * Returns a history of this quiz for the given username in reverse
	 * chronological order.
	 * @param username
	 * @return all quiz history of this quiz and user
	 */
	public QuizTaken[] getUserHistory(String username) {
		return getQuizTakens(
				"select * from TookQuiz where quizId = " + quizId +
				" and username ='" + username + "'" +
				" order by time desc;"
				);
	}

	/**
	 * Returns an array of QuizTaken objects for this quiz ordered by score
	 * (top score first, worst score last).
	 * @return all history of this quiz ordered by score
	 */
	public QuizTaken[] getTopHistory() {
		return getQuizTakens(
				"select * from TookQuiz where quizId = " + quizId +
				" order by score desc, duration asc;"
				);
	}

	/**
	 * Returns the top score of any user for this quiz.
	 * @return The top score, or 0 if no one has taken this quiz.
	 */
	public double getTopScore() {
		QuizTaken[] qts = getTopHistory();
		if (qts == null || qts.length == 0) return 0;
		else return qts[0].getScore();
	}	

	/**
	 * Returns the bottom score of any user for this quiz.
	 * @return The bottom score, or 0 if no one has taken this quiz.
	 */
	public double getBottomScore() {
		QuizTaken[] qts = getTopHistory();
		if (qts == null || qts.length == 0) return 0;
		else return qts[qts.length-1].getScore();
	}



	/**
	 * Returns the top score of this user taking this quiz. Returns 0
	 * if the user has not taken the quiz, or if there is a SQL error.
	 * @param username - the user in question
	 * @return the top score, or 0 if the user has not taken the quiz
	 */
	public double getUserTopScore(String username) {
		QuizTaken[] qts = getQuizTakens(
				"select * from TookQuiz where quizId = " + quizId +
				" and username = '" + username + "'" +
				" order by score desc limit 1;"
				);
		if (qts == null || qts.length == 0) return -1.0;
		else return qts[0].getScore();
	}

	public QuizTaken[] getTopHistoryWithTime() {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		Date yesterdayUnformatted = cal.getTime();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String yesterday = formatter.format(yesterdayUnformatted);
		//		System.out.println("Yesterday: "+yesterday);
		String query = "select * from TookQuiz where quizId = " + quizId +
				" and time > '"+ yesterday + "' order by time desc";
		//		System.out.println(query);
		return getQuizTakens(query);
	}

	// TODO: change all quizId to quizID
	/**
	 * Returns all of the questions for this quiz, in the proper order (either
	 * random or ordered depending on quiz properties).
	 * @return All questions for the quiz
	 */
	public AbstractQuestion[] getQuestions() {
		Connection con = MyDB.getConnection();
		try {
			String query = "select * from Question where quizId = " + quizId +
					" order by orderNumber;";
			Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery(query);
			results.last();
			int numRows = results.getRow();
			results.first();
			AbstractQuestion[] questions = new AbstractQuestion[numRows];
			for (int row = 1; row <= numRows; row++, results.next()) {
				questions[row - 1] = AbstractQuestion.generateQuestion(quizId,
						results.getInt("orderNumber"), results.getString("type"),
						results.getString("text"));
			}
			if (randomOrder) Collections.shuffle(Arrays.asList(questions));
			return questions;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * @param query - a query string which queries the TookQuiz table
	 * @return a QuizTaken array which is the result of executing the query
	 */
	private QuizTaken[] getQuizTakens(String query) {
		Connection con = MyDB.getConnection();
		QuizTaken[] qts;
		try {
			Statement stmt = con.createStatement();
			ResultSet results = stmt.executeQuery(query);
			results.last();
			int numRows = results.getRow();
			results.first();
			qts = new QuizTaken[numRows];
			for (int row = 1; row <= numRows; row++, results.next()) {
				qts[row-1] = new QuizTaken(results.getInt("quizId"),
						results.getString("username"),
						results.getDouble("score"),
						results.getTimestamp("time"),
						results.getInt("duration"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return qts;
	}

	/**
	 * Returns all quizzes in database
	 * @return ArrayList<Announcement> - containing ALL announcements
	 * @author mfidler
	 */
	public static ArrayList<Quiz> viewAllQuizzes() {
		ArrayList<Quiz> qzs = new ArrayList<Quiz>();
		String query = "SELECT * FROM Quiz ORDER BY timeCreated desc"; 
		Connection conn = MyDB.getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement(query);

			ResultSet set = stmt.executeQuery(); 
			while (set.next()) {
				qzs.add(new Quiz(set.getInt("quizID"), set.getString("username"), 
						set.getTimestamp("timeCreated"),  set.getString("name"), 
						set.getString("description"), set.getBoolean("randomOrder"), 
						set.getBoolean("multiplePages"), set.getBoolean("immediateCorrection"),
						set.getBoolean("practiceMode"), set.getInt("secondsPerQuestion"))); 
			}
		} catch(SQLException e) {
			e.printStackTrace(); 
		}
		return qzs;
	}


	/**
	 * Returns all quizzes in database
	 * @return ArrayList<Announcement> - containing ALL announcements
	 * @author mfidler
	 */
	public static int getTotalNumberOfQuizzes() {
		ArrayList<Quiz> qzs = viewAllQuizzes();
		return qzs.size();
	}



	/**
	 * Gets the average score for the quiz it's called on
	 * @author Jujhaar Singh
	 * @return the average score
	 */
	public double averageScore()
	{
		QuizTaken[] qts = getQuizTakens("select * from TookQuiz where quizID=\""+quizId+"\"");
		if (qts.length==0)
			return 0;
		double sum = 0.0;
		for(int i=0; i<qts.length; i++)
		{
			sum += qts[i].getScore();
		}
		double unrounded = sum / qts.length;
		return Quiz.roundToTwoDecimalPlaces(unrounded);
	}
	/**
	 * Gets the average duration for the quiz it's called on
	 * @author Jujhaar Singh
	 * @return the average duration
	 */
	public double averageDuration()
	{
		QuizTaken[] qts = getQuizTakens("select * from TookQuiz where quizID=\""+quizId+"\"");
		if (qts.length==0)
			return 0;
		double sum = 0.0;
		for(int i=0; i<qts.length; i++)
		{
			sum += qts[i].getDuration();
		}
		sum = sum/1000.0;
		double unrounded = sum / qts.length;
		return Quiz.roundToTwoDecimalPlaces(unrounded);
	}
	/**
	 * Get the total number of times the quiz has been taken
	 * @author Jujhaar Singh
	 * @return number of times the quiz has been taken
	 */
	public int numberTimesTaken()
	{
		QuizTaken[] qts = getQuizTakens("select * from TookQuiz where quizID=\""+quizId+"\"");
		return qts.length;
	}

	/**
	 * Utilities method that returns a shortened quiz name. No word in the quiz
	 * name can be longer than numChars characters. 
	 * @author Rupa
	 */
	public static String shortenQuizName(String quizName, int numChars) {
		StringTokenizer tokenizer = new StringTokenizer(quizName); 
		String result = ""; 
		while (tokenizer.hasMoreTokens()) {
			String word = tokenizer.nextToken();
			if (word.length() <= numChars) {
				result += word + " ";
			}
			else {
				result += word.substring(0, numChars); 
				break;
			}
		}
		return result;
	}

	/**
	 * Returns true iff user is owner or admin
	 * @param user
	 * @return if user is owner or admin
	 */
	public boolean canSeeXML(User user) {
		return user != null && (getUsername().equals(user.getUsername()) || user.isAdmin());
	}

	/**
	 * Returns a String of the Quiz in XML
	 * @return the Quiz XML
	 */
	public String toXML() {
		String xml = "";
		xml += "<quiz random=\"" + randomOrder + "\" one-page=\"" + !multiplePages + "\"" +
				" immediate-correction=\"" + immediateCorrection + "\"" +
				" practice-mode=\"" + isPracticeMode + "\"" +
				" seconds-per-question=\"" + secondsPerQuestion + "\">\n";
		xml += "<title>" + name + "</title>\n";
		xml += "<description>" + description + "</description>\n";
		// TODO: random quiz => questions printed in random order :/
		// TODO: categories not implemented
		for (AbstractQuestion question : getQuestions()) {
			xml += question.text + "\n";
		}
		xml += "</quiz>";
		return xml;
	}


	/* 
	 * Returns a list of tags (String) for this particular quiz
	 * @author Rupa
	 */
	public ArrayList<String> getTags() {
		ArrayList<String> tags = new ArrayList<String>();
		Connection conn = MyDB.getConnection();
		String query = "select tag from QuizTags where quizID = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setInt(1, this.quizId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				tags.add(rs.getString("tag"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return tags;
	}
	
	/*
	 * Adds the given tag for the current quiz
	 * @author Rupa
	 */
	public void addTag(String tag) {
		Connection conn = MyDB.getConnection();
		String query = "insert into QuizTags values(?, ?)";
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setInt(1, this.quizId);
			stmt.setString(2, tag);
			stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static ArrayList<Quiz> getQuizzesOfATag(String tag) {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		String query = "select distinct quizID from QuizTags where tag = ?";
		Connection conn = MyDB.getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, tag);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				Quiz quiz = Quiz.readDB(quizID);
				quizzes.add(quiz);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return quizzes;
	}
	
	public static boolean tagExists(String tag) {
		Connection conn = MyDB.getConnection();
		String query = "select * from QuizTags where tag = ?";
		int numRows = 0;
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, tag);
			ResultSet rs = stmt.executeQuery();
			rs.last();
			numRows = rs.getRow();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return !(numRows == 0);
	}
	/*
	 * Sets this.category = category and inserts into the database
	 * @author Rupa
	 */
	public void setCategory(String category) {
		Connection conn = MyDB.getConnection();
		String query = "delete from QuizCategories where quizID = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setInt(1,  this.quizId);
			stmt.executeUpdate();
			query = "insert into QuizCategories values(?, ?)";
			stmt = conn.prepareStatement(query);
			stmt.setInt(1, this.quizId);
			stmt.setString(2, category);
			stmt.executeUpdate();
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/*
	 * Gets this quiz's category from the database
	 * @author Rupa
	 */
	public String getCategory() {
		Connection conn = MyDB.getConnection();
		String category = "Uncategorized";
		String query = "select category from QuizCategories where quizID = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setInt(1,  this.quizId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				category = rs.getString("category");
			}
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return category;
	}
	
	public static ArrayList<String> getAllCategories() {
		ArrayList<String> categories = new ArrayList<String>();
		Connection conn = MyDB.getConnection();
		String query = "select distinct category from QuizCategories";
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				String category = rs.getString("category");
				categories.add(category);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return categories;	
	}
	
	public static ArrayList<Quiz> getQuizzesOfACategory(String category) {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		String query = "select distinct quizID from QuizCategories where category = ?";
		Connection conn = MyDB.getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, category);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				Quiz quiz = Quiz.readDB(quizID);
				quizzes.add(quiz);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return quizzes;
	}
	
	/*
	 * static utility method to round a double to 2 decimal places
	 * @author Rupa
	 */
	
	public static double roundToTwoDecimalPlaces(double d) {
		BigDecimal bd = new BigDecimal(d);
		BigDecimal rounded = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
		d = rounded.doubleValue();
		return d;
	}
}




