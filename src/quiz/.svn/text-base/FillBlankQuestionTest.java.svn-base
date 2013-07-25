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
public class FillBlankQuestionTest {

	@BeforeClass
	public static void setUpBeforeClass() {
		tearDownAfterClass();
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			
			stmt.executeUpdate("insert into Quiz values (1, 'rglobus', NULL, 'The Test', 'Best Test Ever', false, false, false, false);");
			
			String questionXML = "<question type=\"fill-in-blank\"><pre>Is this </pre><blank></blank><post> working? </post><answer-list><answer>test</answer><answer>Test</answer></answer-list></question>";
			stmt.executeUpdate("insert into Question values (1, 1, 'fill-in-blank', '" + questionXML + "', '');");
			
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
		System.out.println("Quiz " + quiz.getQuizId() + ":");
		for (AbstractQuestion q : questions) {
			System.out.println("Quiz " + quiz.getQuizId() + ", Question " + q.number + ":"); // TODO fix hack
			System.out.println(q.toHTML());
			System.out.println();
		}
		assertTrue(questions[0].isCorrect("test"));
		assertFalse(questions[0].isCorrect("no"));
		assertFalse(questions[0].isCorrect(""));
	}

}
