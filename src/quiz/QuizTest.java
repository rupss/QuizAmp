package quiz;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Date;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import database.MyDB;

/**
 * <strong>WARNING: This test will delete all tuples from your Question and Quiz tables.</strong>
 * @author mfidler
 *
 */
public class QuizTest {

	@BeforeClass
	public static void setUpBeforeClass() {
		tearDownAfterClass();
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			
			stmt.executeUpdate("insert into Quiz values (1, 'rglobus', NULL, 'The Test', 'Best Test Ever', false, false, false, false);");
			
			String questionXML = "<question type=\"question-response\"><query>Is this test working?</query><answer-list><answer>Yes</answer><answer>yes</answer></answer-list></question>";
			stmt.executeUpdate("insert into Question values (1, 1, 'question-response', '" + questionXML + "', '');");
			
			questionXML = "<question type=\"picture-response\"><image-location>https://twimg0-a.akamaihd.net/profile_images/1798484398/S_Twitter_white-resize.png</image-location><answer>Stanford</answer></question>";
			stmt.executeUpdate("insert into Question values (1,2, 'picture-response', '" + questionXML + "', '');");
			
			stmt.executeUpdate("insert into Quiz values (2, 'mfidler', NULL, 'The No Questions Test', 'Worst Test Ever', false, false, false, false);");
			
			stmt.executeUpdate("insert into TookQuiz values (1, 'mfidler', 100.0, '2013-02-26 17:07:00', 60);");
			stmt.executeUpdate("insert into TookQuiz values (1, 'mfidler', 93.0, '2013-02-26 18:56:00', 56);");
			stmt.executeUpdate("insert into TookQuiz values (1, 'rupass', 98.7, '2013-02-26 18:53:00', 40);");
			stmt.executeUpdate("insert into TookQuiz values (1, 'rupass', 100.0, '2013-02-19:13:00', 59);");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@AfterClass
	public static void tearDownAfterClass() {
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("delete from Question;");
			stmt.executeUpdate("delete from Quiz;");
			stmt.executeUpdate("delete from TookQuiz");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	@Test
	/* Test for what happens when you try to get questions from a quiz that has none 
	 * Should return an empty array
	 * */
	public void testNoQuestions() {
		assertTrue(true);
		Quiz quiz = Quiz.readDB(2);
		System.out.println("Quiz " + quiz.getQuizId() + ":");
		AbstractQuestion[] questions = quiz.getQuestions();
		System.out.println("How many questions?: " + questions.length);
	}

	
	@Test
	/* Test for Manual Quiz Object creation */
	public void testQuizObject() {
		java.util.Date dt = new java.util.Date();
		Quiz quiz = new Quiz (4, "mfidler", (Timestamp) dt, "QuizObjectQuiz", "Testing for object creation", false, false, false, false,0);
		assertTrue(4 == quiz.getQuizId());
		assertTrue("mfidler".equals(quiz.getUsername()));
		assertTrue(dt.equals(quiz.getTimeCreated()));
		assertTrue("QuizObjectQuiz".equals(quiz.getName()));
		assertTrue("Testing for object creation".equals(quiz.getDescription()));
		assertTrue(false == quiz.isRandomOrder());
		assertTrue(false == quiz.isMultiplePages());
		assertTrue(false == quiz.isImmediateCorrection());
		assertTrue(false == quiz.isPracticeMode());
	}
	
	@Test
	/* Test for getAllHistory */
	public void testGetAllHistory() {
		Quiz quiz1 = Quiz.readDB(1);
		Quiz quiz2 = Quiz.readDB(2);
		QuizTaken[] historyForQuizX = quiz1.getAllHistory();
		System.out.println("Quiz " + quiz1.getQuizId() + " Times taken: " + historyForQuizX.length);
		assertTrue(historyForQuizX.length == 4); //UPDATE WHEN YOU UPDATE TEST START CODE
		for (QuizTaken t: historyForQuizX) {
			System.out.println("Quiz " + t.getQuizId() + " Username: " + t.getUsername() + " Score: " + t.getScore() + " Start time: " + t.getTimeTaken() + " Duration: " + t.getDuration() + " seconds");
		}
		historyForQuizX = quiz2.getAllHistory();
		assertTrue(historyForQuizX.length == 0);
		System.out.println("Quiz " + quiz2.getQuizId() + " Times taken: " + historyForQuizX.length);
	}
	
	@Test
	/* Test for getUserHistory*/
	public void getUserHistoryTest() {
		Quiz quiz1 = Quiz.readDB(1);
		Quiz quiz2 = Quiz.readDB(2);
		QuizTaken[] historyForX = quiz1.getUserHistory("mfidler");
		System.out.println("User mfidler " + quiz1.getQuizId() +" times taken: " + historyForX.length);
		assertTrue(historyForX.length == 2); // CHANGE WHEN UPDATE TEST START CODE
		historyForX = quiz2.getUserHistory("mfidler");
		System.out.println("User mfidler " + quiz1.getQuizId() +" times taken: " + historyForX.length);
		assertTrue(historyForX.length == 0);
	}
	
	@Test
	/* Test for getTopHistory 
	 * (top score first, worst score last).
	 * */
	public void getTopHistoryTest() {
		Quiz quiz1 = Quiz.readDB(1);
		Quiz quiz2 = Quiz.readDB(2);
		QuizTaken[] topHistory1 = quiz1.getTopHistory();
		QuizTaken[] topHistory2 = quiz2.getTopHistory();
		System.out.println("Printing history for quiz " + quiz1.getQuizId());
		for (QuizTaken t : topHistory1) {
			System.out.println("Quiz " + t.getQuizId() + " Username: " + t.getUsername() + " Score: " + t.getScore() + " Start time: " + t.getTimeTaken() + " Duration: " + t.getDuration() + " seconds");
		}
		System.out.println("Printing history for quiz " + quiz2.getQuizId());
		for (QuizTaken t : topHistory2) {
			System.out.println("Quiz " + t.getQuizId() + " Username: " + t.getUsername() + " Score: " + t.getScore() + " Start time: " + t.getTimeTaken() + " Duration: " + t.getDuration() + " seconds");
		}
	}
	
	@Test
	/* Test for get user's top score */
	public void getUserTopScoreTest() {
		Quiz quiz1 = Quiz.readDB(1);
		Quiz quiz2 = Quiz.readDB(2);
		assertTrue(100.0 == quiz1.getUserTopScore("mfidler"));
		assertTrue(0 == quiz2.getUserTopScore("mfidler"));
	}
	
	//TODO Test getTopHistoryWithTime when it is implemented

}