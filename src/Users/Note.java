package Users;

import java.text.ParseException;
import java.util.Date;



public class Note {
	private String fromUsername;
	private String toUsername; 
	private int quizID; 
	private Date date; 
	private String text;
	boolean isRead;
	
	
	public Note (String fromUsername, String toUsername, int quizID, String text, String dateString, boolean isRead) {
		this.fromUsername = fromUsername; 
		this.toUsername = toUsername; 
		this.quizID = quizID; 
		this.isRead = isRead;
		this.text = text;
		java.text.SimpleDateFormat sdf = 
				new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		try {
			this.date = sdf.parse(dateString); 
		}
		catch(ParseException e) {
			e.printStackTrace(); 
		}
	}
	
	public String getFromUsername() {
		return fromUsername;
	}

//	public void setFromUsername(String fromUsername) {
//		this.fromUsername = fromUsername;
//	}

	public String getToUsername() {
		return toUsername;
	}

//	public void setToUsername(String toUsername) {
//		this.toUsername = toUsername;
//	}

	public int getQuizID() {
		return quizID;
	}

//	public void setQuizID(int quizID) {
//		this.quizID = quizID;
//	}

	public Date getDate() {
		return date;
	}

//	public void setDate(Date date) {
//		this.date = date;
//	}
	
	public boolean isRead() {
		return isRead;
	}

	public void setRead(boolean isRead) {
		this.isRead = isRead;
	}

	public String getText() {
		return text;
	}

}