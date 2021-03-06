package Users;

import java.text.ParseException;
import java.util.Date;

public class Announcement {
	
	private String title;
	private String text;
	private String username;
	private Date date;
	private int id;
	
	public Announcement(int id, String title, String text, String username, String dateString) {
		this.id = id;
		this.title = title;
		this.text = text;
		this.username = username;
		java.text.SimpleDateFormat sdf = 
			new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			this.date = sdf.parse(dateString); 
		}
		catch(ParseException e) {
			e.printStackTrace(); 
		}
	}
	
	public String getTitle() {
		return title;
	}
	
	public String getText() {
		return text;
	}
	
	public String getAuthor() {
		return username;
	}
	
	public Date getDate() {
		return date;
	}
	
	public int getId() {
		return id;
	}

}