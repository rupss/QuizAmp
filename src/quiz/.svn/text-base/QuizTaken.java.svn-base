package quiz;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;

import database.MyDB;

public class QuizTaken {
	private int quizId;
	private String username;
	private double score;
	private Timestamp timeTaken;
	private int duration; // in milliseconds
	// TODO: practiceMode???
	
	
	/**
	 * @param quizId
	 * @param username
	 * @param score
	 * @param timeTaken
	 * @param duration
	 */
	public QuizTaken(int quizId, String username, double score, Timestamp timeTaken,
			int duration) {
		this.quizId = quizId;
		this.username = username;
		this.score = score;
		this.timeTaken = timeTaken;
		this.duration = duration;
	}
	
	/**
	 * Returns a QuizTaken from the database with the given quizId, username, and
	 * time (the primary key).
	 * @param quizId
	 * @param username
	 * @param time
	 * @return the QuizTaken. Returns <code>null</code> if there is a SQL error
	 * or no QuizTaken has the given attributes
	 */
	public static QuizTaken readDB(int quizId, String username, Timestamp time) {
		Connection con = MyDB.getConnection();
		try {
			PreparedStatement stmt =
					con.prepareStatement("select * from TookQuiz where quizID = ? and username = ? and time = ?;");
			stmt.setInt(1, quizId);
			stmt.setString(2, username);
			stmt.setTimestamp(3, time);
			ResultSet results = stmt.executeQuery();
			if (!results.first()) return null; // if no results
			return new QuizTaken(quizId, username, results.getDouble("score"),
					time, results.getInt("duration"));
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
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}
	/**
	 * @return the score
	 */
	public double getScore() {
		return score;
	}
	/**
	 * @return the timeTaken
	 */
	public Timestamp getTimeTaken() {
		return timeTaken;
	}
	/**
	 * @return the duration
	 */
	public int getDuration() {
		return duration;
	}
	
	/**
	 * Returns the Quiz associated with this QuizTaken.
	 * @return the Quiz for this QuizTaken, or null if no such quiz exists (the quizId is not in the database)
	 */
	public Quiz getQuiz() {
		return Quiz.readDB(quizId);
	}
	
	
}
