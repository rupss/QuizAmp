package Users;

import java.text.ParseException;
import java.util.*; 

public class FriendRequest {
	private String fromUsername; 
	private String toUsername; 
	private Date date; 
	
	public String getFromUsername() {
		return fromUsername;
	}

	public void setFromUsername(String fromUsername) {
		this.fromUsername = fromUsername;
	}

	public String getToUsername() {
		return toUsername;
	}

	public void setToUsername(String toUsername) {
		this.toUsername = toUsername;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public FriendRequest(String fromUsername, String toUsername, String dateString) {
		this.fromUsername = fromUsername; 
		this.toUsername = toUsername; 
		java.text.SimpleDateFormat sdf = 
				new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		try {
			this.date = sdf.parse(dateString); 
		}
		catch(ParseException e) {
			e.printStackTrace(); 
		}
	}
	
	
}
