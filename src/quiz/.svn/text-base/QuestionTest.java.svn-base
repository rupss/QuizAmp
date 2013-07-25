package quiz;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import database.MyDB;

/**
 * <strong>WARNING: This test will delete all tuples from your Question and Quiz tables.</strong>
 * @author rglobus
 *
 */
public class QuestionTest {

	@BeforeClass
	public static void setUpBeforeClass() {
		tearDownAfterClass();
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			
			stmt.executeUpdate("insert into Quiz values (1, 'rglobus', NULL, 'The Test', 'Best Test Ever', false, false, false, false);");
			
			String questionXML = "<question type=\"question-response\"><query>Is this test working?</query><answer-list><answer>Yes</answer><answer>yes</answer></answer-list></question>";
			stmt.executeUpdate("insert into Question values (1, 1, 'question-response', '" + questionXML + "');");
			
			questionXML = "<question type=\"picture-response\"><image-location>https://twimg0-a.akamaihd.net/profile_images/1798484398/S_Twitter_white-resize.png</image-location><answer>Stanford</answer></question>";
			stmt.executeUpdate("insert into Question values (1,2, 'picture-response', '" + questionXML + "');");
			
			questionXML = "<question type=\"fill-in-blank\"><pre>Is this </pre><blank></blank><post> working? </post><answer-list><answer>test</answer><answer>Test</answer></answer-list></question>";
			stmt.executeUpdate("insert into Question values (1, 3, 'fill-in-blank', '" + questionXML + "');");
			
			questionXML = "<question type=\"multiple-choice\"><query>Choose one of the following</query>" +
					"<option>A) Ryan is the best</option><option>B) Jujhaar is the best</option><option answer=\"answer\">C) Both are true</option></question>";
			stmt.executeUpdate("insert into Question values(1, 4, 'multiple-choice', '" + questionXML + "');");
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
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void test() {
		assertTrue(true);
		Quiz quiz = Quiz.readDB(1);
		AbstractQuestion[] questions = quiz.getQuestions();
//		System.out.println("Quiz " + quiz.getQuizId() + ":");
		for (AbstractQuestion q : questions) {
//			System.out.println("Quiz " + quiz.getQuizId() + ", Question " + q.number + ":"); // TODO fix hack should be getter
//			System.out.println(q.toHTML());
//			System.out.println("XML = " + q.toXML());
//			System.out.println();
		}
		assertTrue(questions[0].isCorrect("yes"));
		assertFalse(questions[0].isCorrect("no"));
		assertFalse(questions[0].isCorrect(""));
		
		assertTrue(questions[1].isCorrect("Stanford"));
		assertFalse(questions[1].isCorrect("stanford"));
		
		assertTrue(questions[2].isCorrect("test"));
		assertTrue(questions[2].isCorrect("Test"));
		assertFalse(questions[2].isCorrect("other"));
		
		assertTrue(questions[3].isCorrect("C) Both are true"));
		assertFalse(questions[3].isCorrect("B) Jujhaar is the best"));

	}

}
