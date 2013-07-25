package quiz;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import database.MyDB;

/**
 * Similar to QuestionTest, except now with new methods, this test does not need to directly execute
 * SQL statements.
 * <strong>WARNING: This test will delete all tuples from your Question and Quiz tables.</strong>
 * @author rglobus
 *
 */
public class QuestionTest2 {

	@BeforeClass
	public static void setUpBeforeClass() {
		tearDownAfterClass();
		Quiz stanfordQuiz = Quiz.createQuiz("rglobus", new Timestamp(new java.util.Date().getTime()), "Stanford", "", false, false, false, false,0);
		Quiz flomoQuiz = Quiz.createQuiz("rglobus", new Timestamp(new java.util.Date().getTime()), "FloMo", "Flomo's best \"quiz\"", false, false, false, false,0);
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
			System.out.println("Quiz " + quiz.getQuizId() + ", Question " + q.number + ":"); // TODO fix hack should be getter
			System.out.println(q.toHTML());
			System.out.println("XML = " + q.toXML());
			System.out.println();
		}
		assertTrue(questions[0].isCorrect("yes"));
		assertFalse(questions[0].isCorrect("no"));
		assertFalse(questions[0].isCorrect(""));
		
		assertTrue(questions[1].isCorrect("Stanford"));
		assertFalse(questions[1].isCorrect("stanford"));
		
		assertTrue(questions[2].isCorrect("test"));
		assertTrue(questions[2].isCorrect("Test"));
		assertFalse(questions[2].isCorrect("other"));
		
		//TODO: Test multiple choice questions
	}

}
