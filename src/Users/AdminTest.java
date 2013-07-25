package Users;

import static org.junit.Assert.*;


import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.junit.AfterClass;
import org.junit.Before;
import org.junit.Test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import quiz.*; 
import database.MyDB;

public class AdminTest {

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("TRUNCATE TABLE User;");
			stmt.executeUpdate("TRUNCATE TABLE Announcements;");
			stmt.executeUpdate("TRUNCATE TABLE Friend;");
			stmt.executeUpdate("TRUNCATE TABLE Achievements;");
			stmt.executeUpdate("TRUNCATE TABLE TookQuiz;");
			stmt.executeUpdate("TRUNCATE TABLE UserVisibleAnnouncements;");
			stmt.executeUpdate("TRUNCATE TABLE Quiz;");

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Before
	public void setUp() {
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("TRUNCATE TABLE User;");
			stmt.executeUpdate("TRUNCATE TABLE Announcements;");
			stmt.executeUpdate("TRUNCATE TABLE Friend;");
			stmt.executeUpdate("TRUNCATE TABLE Achievements;");
			stmt.executeUpdate("TRUNCATE TABLE TookQuiz;");
			stmt.executeUpdate("TRUNCATE TABLE UserVisibleAnnouncements;");
			stmt.executeUpdate("TRUNCATE TABLE Quiz;");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


	@Test
	public void testRemoveUserAccount() {
		Connection conn = MyDB.getConnection(); 
		User user = new User(); 
		user.addUser("kuda", "password"); 
		user.setAdmin(true); 
		String time1 = "2013-03-02 13:51:03"; 
		String time2 = "2012-03-02 13:51:03"; 
		try {
			Statement stmt = conn.createStatement(); 
			String query1 = "INSERT INTO Friend VALUES(\"rupa\", \"mailyn\", true, '" + time1 + "')"; 
			String query2 = "INSERT INTO Friend VALUES(\"mailyn\", \"rupa\", true, '" + time1 + "')"; 
			String query3 = "INSERT INTO Friend VALUES(\"rupa\", \"ryan\", false, '" + time2 + "')"; 
			
			String query4 = "INSERT INTO Friend VALUES(\"ryan\", \"mailyn\", true, '" + time1 + "')"; 
			String query5 = "INSERT INTO Friend VALUES(\"mailyn\", \"ryan\", true, '" + time1 + "')"; 
			stmt.executeUpdate(query1); 
			stmt.executeUpdate(query2); 
			stmt.executeUpdate(query3);
			stmt.executeUpdate(query4);
			stmt.executeUpdate(query5);
			query1 = "INSERT INTO TookQuiz VALUES(12, \"rupa\", 14.0, " + "'" + time1 + "', 60, true)"; 
			query2 = "INSERT INTO TookQuiz VALUES(14, \"rupa\", 14.0, " + "'" + time2 + "', 60, false)"; 
			query3 = "INSERT INTO TookQuiz VALUES(16, \"rupa\", 14.0, " + "'" + time1 + "', 60, false)"; 
			
			query4 = "INSERT INTO TookQuiz VALUES(16, \"ryan\", 14.0, " + "'" + time1 + "', 60, false)"; 
			stmt.executeUpdate(query1); 
			stmt.executeUpdate(query2); 
			stmt.executeUpdate(query3);
			stmt.executeUpdate(query4);
			query1 = "INSERT INTO UserVisibleAnnouncements VALUES(\"rupa\", 15)"; 
			query2 = "INSERT INTO UserVisibleAnnouncements VALUES(\"rupa\", 18)"; 
			
			query3 = "INSERT INTO UserVisibleAnnouncements VALUES(\"ryan\", 18)"; 
			stmt.executeUpdate(query1); 
			stmt.executeUpdate(query2); 
			stmt.executeUpdate(query3); 
			query1 = "INSERT INTO Achievements VALUES(\"rupa\", \"prodigious\")"; 
			query2 = "INSERT INTO Achievements VALUES(\"rupa\", \"master\")"; 
			
			query3 = "INSERT INTO Achievements VALUES(\"ryan\", \"master\")"; 
			stmt.executeUpdate(query1); 
			stmt.executeUpdate(query2); 
			stmt.executeUpdate(query3); 
		}
		catch (SQLException e) {
			e.printStackTrace(); 
		}
		user.removeUserAccount("rupa"); 
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM Friend WHERE friend1=\"rupa\" OR friend2=\"rupa\""); 
			rs.last(); 
			assertEquals(0, rs.getRow()); //empty set
			rs = stmt.executeQuery("SELECT * FROM TookQuiz WHERE username=\"rupa\""); 
			rs.last(); 
			assertEquals(0, rs.getRow()); //empty set
			rs = stmt.executeQuery("SELECT * FROM UserVisibleAnnouncements WHERE username=\"rupa\""); 
			rs.last(); 
			assertEquals(0, rs.getRow()); //empty set
			rs = stmt.executeQuery("SELECT * FROM Achievements WHERE username=\"rupa\""); 
			rs.last(); 
			assertEquals(0, rs.getRow()); //empty set
			
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		User user2 = new User(); 
		user2.addUser("mailyn", "password");
		user2.removeUserAccount("ryan"); 
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM Friend WHERE friend1=\"ryan\" OR friend2=\"ryan\""); 
			rs.last(); 
			assertEquals(2, rs.getRow()); //empty set
			rs = stmt.executeQuery("SELECT * FROM TookQuiz WHERE username=\"ryan\""); 
			rs.last(); 
			assertEquals(1, rs.getRow()); //empty set
			rs = stmt.executeQuery("SELECT * FROM UserVisibleAnnouncements WHERE username=\"ryan\""); 
			rs.last(); 
			assertEquals(1, rs.getRow()); //empty set
			rs = stmt.executeQuery("SELECT * FROM Achievements WHERE username=\"ryan\""); 
			rs.last(); 
			assertEquals(1, rs.getRow()); //empty set
			
		}
		catch (SQLException e) {
			e.printStackTrace(); 
		}
		
	}

	
	@Test
	public void testAddAnnouncement() {
		User admin = new User();
		admin.addUser("admin", "topdog");
		admin.setAdmin(true);
		admin.createAnnouncement("Emergency", "This is a test");
		admin.createAnnouncement("No More Cheating", "Really");
		ArrayList<Announcement> anc = admin.getAdminAnnouncements();
		assertTrue(anc.size() == 2);
		for (Announcement a : anc) {
			System.out.println(a.getTitle() + " " + a.getText());
		}
		User superAdmin = new User();
		superAdmin.addUser("superUser", "mwhaha");
		superAdmin.setAdmin(true);
		superAdmin.createAnnouncement("Trounced!", "I win");
		ArrayList<Announcement> sancs = superAdmin.getAdminAnnouncements();
		assertTrue(sancs.size() == 1);
		System.out.println(" ");
		for (Announcement a : sancs) {
			System.out.println(a.getTitle() + " " + a.getText());
		}
		ArrayList<Announcement> ancs = superAdmin.viewAllAnnouncements();
		System.out.println(" ");
		System.out.println("All announcements EVER!");
		System.out.println(" ");
		for (Announcement a : ancs) {
			System.out.println(a.getTitle() + " " + a.getText());
		}
		
	}
	@Test
	public void testSetUserAdminStatus() {
		User admin = new User();
		admin.addUser("admin", "topdog");
		admin.setAdmin(true);
		
		User superAdmin = new User();
		superAdmin.addUser("superUser", "mwhaha");
		superAdmin.setAdmin(true);
		
		superAdmin.setUserAdminStatus("admin", false);
		assertTrue(!admin.isAdmin());
		
		superAdmin.setUserAdminStatus("admin", true);
		assertTrue(admin.isAdmin());
	}
	
	@Test
	public void testRemoveQuiz() {
		/*public static Quiz createQuiz(String username, Date timeCreated, String name,
				String description, boolean randomOrder, boolean multiplePages,
				boolean immediateCorrection, boolean isPracticeMode)  */
		Connection conn = MyDB.getConnection(); 
		String time1 = "2013-03-02 13:51:03"; 
		try {
			Statement stmt = conn.createStatement(); 
			String query = "INSERT INTO Quiz values(10, \"rupa\", '" + time1 + "', \"awesome\", \"none needed\", false, false, false, false)"; 
			String query2 = "INSERT INTO Quiz values(13, \"rupa\", '" + time1 + "', \"awesome 2\", \"none needed\", false, false, false, false)"; 
			
			stmt.executeUpdate(query); 
			stmt.executeUpdate(query2); 
		}
		catch (SQLException e) {
			e.printStackTrace(); 
		}
		
		User user = new User(); 
		user.addUser("rupa", "password");
		user.removeQuiz(10); 
		try {
			Statement stmt = conn.createStatement(); 
			String query = "SELECT * FROM Quiz"; 
			ResultSet rs = stmt.executeQuery(query); 
			rs.last(); 
			assertEquals(2, rs.getRow());
		}
		catch (SQLException e) {
			e.printStackTrace(); 
		}
		
		user.removeQuiz(20); 
		
		try {
			Statement stmt = conn.createStatement(); 
			String query = "SELECT * FROM Quiz"; 
			ResultSet rs = stmt.executeQuery(query); 
			rs.last(); 
			assertEquals(2, rs.getRow());
		}
		catch (SQLException e) {
			e.printStackTrace(); 
		}
		user.setAdmin(true); 
		user.removeQuiz(10); 
		
		try {
			Statement stmt = conn.createStatement(); 
			String query = "SELECT * FROM Quiz"; 
			ResultSet rs = stmt.executeQuery(query); 
			rs.last(); 
			assertEquals(1, rs.getRow());
		}
		catch (SQLException e) {
			e.printStackTrace(); 
		}
		
	}
	
	@Test
	public void testGetTotalNumberOfUsers() {
		Connection conn = MyDB.getConnection(); 
		User user = new User(); 
		
		//assertEquals(user.getTotalNumberOfUsers(), 0); 
		
		user.addUser("kuda", "password"); 
		user.setAdmin(true); 
		
		try {
			Statement stmt = conn.createStatement(); 
			String query = "insert into User values(\"mailyn\", \"jdfsf\", false, \"dfdfdf\")"; 
			String query2 = "insert into User values(\"rupa\", \"jdfsf\", false, \"dfdfdf\")"; 
			stmt.executeUpdate(query); 
			stmt.executeUpdate(query2); 
			assertEquals(user.getTotalNumberOfUsers(), 3); 
		}
		catch (SQLException e) {
			e.printStackTrace(); 
		}
		
	}
	
	@Test
	public void testgetTopThreeQuizTakers() {
		Connection conn = MyDB.getConnection(); 
		User user = new User();
		user.addUser("rupa", "password"); 
		user.setAdmin(true); 
		try {
			Statement stmt = conn.createStatement();
			String query = "insert into TookQuiz values(10, \"ry\", 1000.0, '0000-00-00 00:00:00', 60, false)"; 
			String query2 = "insert into TookQuiz values(11, \"rupa\", 1000.0, '0000-00-00 00:00:00', 60, false)"; 
			String query3 = "insert into TookQuiz values(10, \"rupa\", 1000.0, '0000-00-00 00:00:00', 60, false)"; 
			String query4 = "insert into TookQuiz values(13, \"rupa\", 1000.0, '0000-00-00 00:00:00', 60, false)"; 
			String query5 = "insert into TookQuiz values(10, \"juj\", 1000.0, '0000-00-00 00:00:00', 60, false)";
			String query6 = "insert into TookQuiz values(10, \"mailyn\", 1000.0, '0000-00-00 00:00:00', 60, false)";
			String query7 = "insert into TookQuiz values(10, \"kuda\", 1000.0, '0000-00-00 00:00:00', 60, false)";
			stmt.executeUpdate(query); 
			stmt.executeUpdate(query2); 
			stmt.executeUpdate(query3); 
			stmt.executeUpdate(query4); 
			stmt.executeUpdate(query5); 
			stmt.executeUpdate(query6); 
			stmt.executeUpdate(query7); 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		Map<String, Integer> map = user.getTopThreeQuizTakers(); 
		for (String name : map.keySet()) {
			System.out.println(name); 
			System.out.println(map.get(name)); 
		}
		
	}
	
	
	@Test 
	public void testClearQuizHistoryAndTotalQuizTaken() {
		User admin = new User();
		admin.addUser("admin", "topdog");
		admin.setAdmin(true);
		
		User testTaker1 = new User();
		testTaker1.addUser("testTaker1", "1");
		
		User testTaker2 = new User();
		testTaker2.addUser("testTaker2", "2");
		
		Connection con = MyDB.getConnection();
		try {
			
			String time1 = "2013-03-02 13:51:03"; 
			String time2 = "2012-03-02 13:51:04"; 
			String time3 = "2013-03-02 15:00:00";
			
			Statement stmt = con.createStatement();
			
			
			Date date = new Date();
			Quiz frasier = Quiz.createQuiz("admin", null, "Psychoanalysis", "See if you can beat this, Niles!", false, false, false, false,0);
			date = new Date();
			Quiz niles = Quiz.createQuiz("admin", null, "Freud", "All about one thing", false, false, false, false,0);
			
			/* T1 took frasier */ 
			int fid = frasier.getQuizId();
			String query = "insert into TookQuiz (quizID, username, score, time, duration, practiceMode) values (" + fid + ", 'testTaker1', 100.0, '" +  time3 +  "', 60, false);";
			stmt.executeUpdate(query);
			/*T1 took niles */
			int nid = niles.getQuizId();
			query = "insert into TookQuiz (quizID, username, score, time, duration, practiceMode) values (" + nid + ", 'testTaker1', 96.0, '" +  time1 +  "', 42, false);";
			stmt.executeUpdate(query);
			
			/*T2 took niles */
			query = "insert into TookQuiz (quizID, username, score, time, duration, practiceMode) values (" + nid + ", 'testTaker2', 96.0, '" +  time1 +  "', 42, false);";
			stmt.executeUpdate(query);
			
			/* CHECK HISTORY FOR NILES AND FRASIER QUIZZES */
			QuizTaken[] allHistoryNiles = niles.getAllHistory();
			System.out.println("ALL HISTORY NILES");
			for (QuizTaken q : allHistoryNiles) {
				Quiz qz = q.getQuiz();
				System.out.println(q.getUsername() + " " + qz.getName() + " " + q.getScore());
			}
			System.out.println("ALL HISTORY FRASIER");
			QuizTaken[] allHistoryFrasier = frasier.getAllHistory();
			for (QuizTaken q : allHistoryFrasier) {
				Quiz qz = q.getQuiz();
				System.out.println(q.getUsername() + " " + qz.getName() + " " + q.getScore());
			}
			
			int total = admin.getTotalQuizzesTaken();
			System.out.println("Total Taken: " + total);
			assertEquals(total, 3);
			
			/* Clear history for Niles */
			admin.clearQuizHistory(nid);
			System.out.println(" REMOVING NILES");
			System.out.println(" ");
			
			/* CHECK -> HALF EMPTY*/
			 allHistoryNiles = niles.getAllHistory();
			System.out.println("ALL HISTORY NILES");
			for (QuizTaken q : allHistoryNiles) {
				Quiz qz = q.getQuiz();
				System.out.println(q.getUsername() + " " + qz.getName() + " " + q.getScore());
			}
			System.out.println("ALL HISTORY FRASIER");
			allHistoryFrasier = frasier.getAllHistory();
			for (QuizTaken q : allHistoryFrasier) {
				Quiz qz = q.getQuiz();
				System.out.println(q.getUsername() + " " + qz.getName() + " " + q.getScore());
			}
			
			total = admin.getTotalQuizzesTaken();
			System.out.println("Total Taken: " + total);
			assertEquals(total, 1);
			
			/* Clear history for Frasier */
			
			admin.clearQuizHistory(fid);
			System.out.println(" REMOVING FRASIER");
			System.out.println(" ");
			
			/* CHECK -> ALL EMPTY*/
			 allHistoryNiles = niles.getAllHistory();
				System.out.println("ALL HISTORY NILES");
				for (QuizTaken q : allHistoryNiles) {
					Quiz qz = q.getQuiz();
					System.out.println(q.getUsername() + " " + qz.getName() + " " + q.getScore());
				}
				System.out.println("ALL HISTORY FRASIER");
				allHistoryFrasier = frasier.getAllHistory();
				for (QuizTaken q : allHistoryFrasier) {
					Quiz qz = q.getQuiz();
					System.out.println(q.getUsername() + " " + qz.getName() + " " + q.getScore());
				}
				
				total = admin.getTotalQuizzesTaken();
				System.out.println("Total Taken: " + total);
				assertEquals(total, 0);
			
			
			
		} catch (SQLException e) {
			e.printStackTrace(); 
		}
	}
	

	@Test
	public void testGetProlificCreators() {
		Connection conn = MyDB.getConnection(); 
		User user = new User();
		user.addUser("rupa", "password"); 
		user.setAdmin(true); 
		try {
			Statement stmt = conn.createStatement();
			String query = "insert into Quiz values(10, \"rupa\", '2011-03-02 13:51:03', \"awesome\", \"dsfsf\", false, false, false, false)";
			String query2 = "insert into Quiz values(11, \"rupa\", '2011-03-02 13:51:03', \"awesome\", \"dsfsf\", false, false, false, false)";
			String query3 = "insert into Quiz values(12, \"rupa\", '2011-03-02 13:51:03', \"awesome\", \"dsfsf\", false, false, false, false)";
			String query4 = "insert into Quiz values(13, \"juj\", '2011-03-02 13:51:03', \"awesome\", \"dsfsf\", false, false, false, false)";
			String query5 = "insert into Quiz values(14, \"juj\", '2011-03-02 13:51:03', \"awesome\", \"dsfsf\", false, false, false, false)";
			String query6 = "insert into Quiz values(15, \"ryan\", '2011-03-02 13:51:03', \"awesome\", \"dsfsf\", false, false, false, false)";
			String query7 = "insert into Quiz values(16, \"mailyn\", '2011-03-02 13:51:03', \"awesome\", \"dsfsf\", false, false, false, false)";
			String query8 = "insert into Quiz values(17, \"kuda\", '2011-03-02 13:51:03', \"awesome\", \"dsfsf\", false, false, false, false)";
			stmt.executeUpdate(query); 
			stmt.executeUpdate(query2); 
			stmt.executeUpdate(query3); 
			stmt.executeUpdate(query4); 
			stmt.executeUpdate(query5); 
			stmt.executeUpdate(query6); 
			stmt.executeUpdate(query7); 
			stmt.executeUpdate(query8); 
		}
		catch (SQLException e) {
			e.printStackTrace(); 
		}
		
		ArrayList<String> creators = user.getProlificCreators(); 
		for (String c : creators) {
			System.out.println(c); 
		}
		
	}
	

	@Test
	public void testTopThreeScores() {
		User one = new User();
		one.addUser("one", "1");
		
		User two = new User();
		two.addUser("two", "2");
		
		User three = new User();
		three.addUser("three", "3");
		
		User four = new User();
		four.addUser("four", "4");
		
		String time1 = "2013-03-02 13:51:03"; 
		String time2 = "2012-03-02 13:51:04"; 
		String time3 = "2013-03-02 15:00:00";
		
		Date date = new Date();
		Quiz frasier = Quiz.createQuiz("admin", null, "Psychoanalysis", "See if you can beat this, Niles!", false, false, false, false,0);
		date = new Date();
		Quiz niles = Quiz.createQuiz("admin", null, "Freud", "All about one thing", false, false, false, false,0);
		
		Connection con = MyDB.getConnection();
		Statement stmt;
		try {
			stmt = con.createStatement();
			
			int fid = frasier.getQuizId();
			String query = "insert into TookQuiz (quizID, username, score, time, duration, practiceMode) values (" + fid + ", 'one', 100.0, '" +  time3 +  "', 60, false);";
			stmt.executeUpdate(query);
			query = "insert into TookQuiz (quizID, username, score, time, duration, practiceMode) values (" + fid + ", 'one', 100.0, '" +  time2 +  "', 59, false);";
			stmt.executeUpdate(query);
			query = "insert into TookQuiz (quizID, username, score, time, duration, practiceMode) values (" + fid + ", 'two', 98.0, '" +  time1 +  "', 30, false);";
			stmt.executeUpdate(query);
			query = "insert into TookQuiz (quizID, username, score, time, duration, practiceMode) values (" + fid + ", 'three', 70.0, '" +  time1 +  "', 89, false);";
			stmt.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		one.setAdmin(true);
		
		ArrayList<QuizTaken> qt = one.getTopThreeScores();
		
		for (QuizTaken q : qt) {
			System.out.println(q.getUsername() + " " + q.getScore() + " " +  q.getDuration());
		}
		
		
		
		
	}
	


}
