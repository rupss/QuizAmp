package Users;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.junit.Test;


public class NoteTest {

	
	@Test
	public void testForSendingOneNote() {
		User.purgeUsersTable();
		User.purgeMessagesTable();
		
	
		User user1 = new User();
		User user2 = new User();
		User user3 = new User();
		
		user1.addUser("user1", "user1"); //add for commit
		user2.addUser("user2", "user2");
		user3.addUser("user3", "user3");
		
		String note = "This is not an emergency.";
		user1.sendNote("user2", note);
		String note2 = "Striving to be a philosopher mechanic.";
		user3.sendNote("user2", note2);
		user3.sendNote("user3", "What up, me?");
		
		ArrayList<Note> notesUser2 = user2.getNotes();
		if (notesUser2.size() > 0) {
			for (Note n : notesUser2) {
				System.out.println("2 " + n.getText() + " " + n.getFromUsername());
				
			}
		}
		ArrayList<Note> notesUser1 = user1.getNotes();
		if (notesUser1.size() > 0) {
			for (Note n : notesUser2) {
				System.out.println("1 " + n.getText() + " " + n.getFromUsername());
			}
		}
		ArrayList<Note> notesUser3 = user3.getNotes();
		if (notesUser3.size() > 0) {
			for (Note n : notesUser3) {
				System.out.println("3 " + n.getText() + " " + n.getFromUsername());
			}
		}
	
		
	}
}
