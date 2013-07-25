package Users;

import java.util.Date;
import quiz.*;


/**
 * 
 * @author mfidler
 *
 */
public class Activity {
	
	private String username;
	private int quizID;
	private String quizName;
	private double score; // -1 if not applicable
	private Date date;
	private int duration; //-1 if not applicable
	private boolean created; // true if created, false if took
	
	public Activity(Quiz quiz) {
		username = quiz.getUsername();
		quizName = quiz.getName();
		quizID = quiz.getQuizId();
		score = -1;
		date = quiz.getTimeCreated();
		duration = -1;
		created = true;
	}
	
	public Activity(QuizTaken qt) {
		username = qt.getUsername();
		Quiz quiz = qt.getQuiz();
		quizName = quiz.getName();
		quizID = qt.getQuizId();
		score = qt.getScore();
		date = qt.getTimeTaken();
		duration = qt.getDuration();
		created = false;
	}
	
	public String getUsername() {
		return username;
	}
	
	public int getQuizID() {
		return quizID;
	}
	
	public String getQuizName() {
		return quizName;
	}
	
	public double getScore() {
		return score;
	}
	
	public Date getDate() {
		return date;
	}
	
	public int getDuration() {
		return duration;
	}
	
	public boolean getCreated() {
		return created;
	}
}