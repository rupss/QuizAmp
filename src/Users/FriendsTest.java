package Users;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import org.junit.Test;

import quiz.Quiz;
import database.MyDB;

public class FriendsTest {

	@Test
	public void testForAddingOneFriend() { //for commit
		User.purgeUsersTable();
		User.purgeFriendsTable();

		User user1 = new User();
		User user2 = new User();

		user1.addUser("user1", "user1");
		user2.addUser("user2", "user2");

		user1.sendFriendRequest("user2");
		user2.processFriendRequest(true, "user1");

		assertTrue(user1.isFriendsWith("user2"));
		assertTrue(user2.isFriendsWith("user1"));

	}

	@Test 
	public void testUnfriending(){
		User.purgeUsersTable();
		User.purgeFriendsTable();

		User user1 = new User();
		User user2 = new User();

		user1.addUser("user1", "user1");
		user2.addUser("user2", "user2");

		user1.sendFriendRequest("user2");
		user2.processFriendRequest(true, "user1");

		assertTrue(user1.isFriendsWith("user2")); 
		assertTrue(user2.isFriendsWith("user1"));

		user1.processFriendRequest(false, "user2");

		assertTrue(!(user1.isFriendsWith("user2")));
		assertTrue(!(user2.isFriendsWith("user1")));		
	}

	/*Checks that people are not made friends as soon as they are created*/
	@Test
	public void testFriendsJustAdded(){
		User.purgeUsersTable();
		User.purgeFriendsTable();

		User user1 = new User();
		User user2 = new User();

		user1.addUser("user1", "user1");
		user2.addUser("user2", "user2");

		assertTrue(!(user1.isFriendsWith("user2")));
		assertTrue(!(user2.isFriendsWith("user1")));

	}

	@Test
	public void testForGetFriends(){
		User.purgeUsersTable();
		User.purgeFriendsTable();
		ArrayList<String> friends = new ArrayList<String>();
		ArrayList<String> friendsUser2 = new ArrayList<String>();

		friends.add("user2");
		friends.add("user3");
		friendsUser2.add("user1");

		User user1 = new User();
		User user2 = new User();
		User user3 = new User();

		user1.addUser("user1", "user1");
		user2.addUser("user2", "user2");
		user3.addUser("user3", "user3");

		user1.sendFriendRequest("user2");
		user2.processFriendRequest(true, "user1");

		user1.sendFriendRequest("user3");
		user3.processFriendRequest(true, "user1");

		assertTrue(friends.equals(user1.getFriends()));
		assertTrue(friendsUser2.equals(user2.getFriends()));


		// test for get friends after an unfriending has occurred
		user1.processFriendRequest(false, "user3");
		friends.remove(1);
		assertTrue(friends.equals(user1.getFriends()));

	}

	@Test
	public void testForUnfriending(){
		User.purgeUsersTable();
		User.purgeFriendsTable();

		User user1 = new User();
		User user2 = new User();
		User user3 = new User();

		user1.addUser("user1", "user1");
		user2.addUser("user2", "user2");
		user3.addUser("user3", "user3");

		user1.sendFriendRequest("user2");
		user2.processFriendRequest(true, "user1");
		user1.processFriendRequest(false, "user2");

		assertFalse(user1.isFriendsWith("user2"));	

		//test process friend request for a friend that has not sent a request
		user1.processFriendRequest(true, "user3");
		assertFalse(user1.isFriendsWith("user3"));
		assertFalse(user3.isFriendsWith("user1"));
	}

	@Test
	public void testBlankGetUsers(){
		User.purgeUsersTable();
		User.purgeFriendsTable();

		ArrayList<String> friends = new ArrayList<String>();
		User user1 = new User();
		user1.addUser("user1", "user1");
		assertTrue(friends.equals(user1.getFriends()));

	}

	/*Test to see if a user's friend list is blank when they have a pending request*/
	@Test
	public void testBlankGetUsers2(){
		User.purgeUsersTable();
		User.purgeFriendsTable();

		ArrayList<String> friends = new ArrayList<String>();
		User user1 = new User();
		User user2 = new User();

		user1.addUser("user1", "user1");
		user2.addUser("user2", "user2");

		user2.sendFriendRequest("user1");
		assertTrue(friends.equals(user1.getFriends()));

	}

	@Test
	public void testForPendingFriendship(){
		User.purgeUsersTable();
		User.purgeFriendsTable();

		User user1 = new User();
		User user2 = new User();

		user1.addUser("user1", "user1");
		user2.addUser("user2", "user2");

		user2.sendFriendRequest("user1");

		assertTrue(user1.hasPendingFriendshipWith("user2"));

		user1.processFriendRequest(true, "user2");
		assertTrue(user1.isFriendsWith("user2"));
		assertTrue(user2.isFriendsWith("user1"));
		assertFalse(user2.hasPendingFriendshipWith("user1"));
		assertFalse(user1.hasPendingFriendshipWith("user2"));
	}

	@Test
	public void testForRejectingFriendRequest(){
		// test rejecting friend request
		User user3 = new User();
		User user4 = new User();

		user3.addUser("user3", "user3");
		user4.addUser("user4", "user4");

		user4.sendFriendRequest("user3");
		assertTrue(user3.hasPendingFriendshipWith("user4"));

		user3.processFriendRequest(false, "user4");
		assertFalse(user3.isFriendsWith("user4"));
		assertFalse(user4.isFriendsWith("user3"));
		assertFalse(user4.hasPendingFriendshipWith("user3"));
		assertFalse(user3.hasPendingFriendshipWith("user4"));
	}


	@Test
	public void testGetFriendActivity() {
		Connection conn = MyDB.getConnection(); 
		User user = new User();
		User.purgeFriendsTable(); 
		User.purgeUsersTable(); 
		User.purgeMessagesTable(); 

		User Frasier = new User();
		Frasier.addUser("Frasier", "radio");
		User Niles = new User();
		Niles.addUser("Niles", "psychology");
		User Lillith = new User();
		Lillith.addUser("Lillith", "theicewomancometh");
		User Martin = new User();
		Martin.addUser("Martin", "chair");



		try {
			Statement stmt = conn.createStatement();


			String time1 = "2013-03-02 13:51:03"; 
			String time2 = "2012-03-02 13:51:04"; 
			String time3 = "2013-03-02 15:00:00";

			java.util.Date dt = new java.util.Date();

			java.text.SimpleDateFormat sdf = 
					new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			String currentTime = sdf.format(dt);
			/* F & N are friends */ String query = "INSERT INTO Friend VALUES(\"Frasier\", \"Niles\", " + true + ", '" + currentTime + "'" + ")";
			stmt.executeUpdate(query); 
			/* N & F are friends */ query = "INSERT INTO Friend VALUES(\"Niles\", \"Frasier\", true, " + "'" + currentTime + "'" + ")";
			stmt.executeUpdate(query); 
			/* F & L are not friends */ query = "INSERT INTO Friend VALUES(\"Frasier\", \"Lillith\", false, " + "'" + currentTime + "'" + ")";
			/* F & M are friends */
			/* F & N are friends */ query = "INSERT INTO Friend VALUES(\"Frasier\", \"Martin\", " + true + ", '" + currentTime + "'" + ")";
			stmt.executeUpdate(query); 
			/* N & F are friends */ query = "INSERT INTO Friend VALUES(\"Martin\", \"Frasier\", true, " + "'" + currentTime + "'" + ")";




			/* F creates */  
			Date date = new Date();
			Quiz frasier = Quiz.createQuiz("Frasier", new Timestamp(date.getTime()), "Psychoanalysis", "See if you can beat this, Niles!", false, false, false, false,0);

			/* N creates */ 
			date = new Date();
			Quiz niles = Quiz.createQuiz("Niles", new Timestamp(date.getTime()), "Freud", "All about one thing", false, false, false, false,0);
			/* N took frasier */ 
			int fid = frasier.getQuizId();
			query = "insert into TookQuiz (quizID, username, score, time, duration, practiceMode) values (" + fid + ", 'Niles', 100.0, '" +  time3 +  "', 60, false);";
			stmt.executeUpdate(query);
			/*N took niles */
			int nid = niles.getQuizId();
			query = "insert into TookQuiz (quizID, username, score, time, duration, practiceMode) values (" + nid + ", 'Niles', 96.0, '" +  time1 +  "', 42, false);";
			stmt.executeUpdate(query);

			/*M took niles */
			query = "insert into TookQuiz (quizID, username, score, time, duration, practiceMode) values (" + nid + ", 'Martin', 96.0, '" +  time1 +  "', 42, false);";
			stmt.executeUpdate(query);
		}
		catch(SQLException e) {
			e.printStackTrace(); 
		}

		ArrayList<Activity> frasierFriendActivity = Frasier.getFriendActivity();

		for (Activity a : frasierFriendActivity) {
			System.out.println("Friend who did this: " + a.getUsername());
			System.out.println("Created or taken: ");
			if (a.getCreated() == true)
				System.out.println("Created");
			else
				System.out.println("Taken");
			System.out.println("Quiz id: " + a.getQuizID());
			System.out.println("Quiz name: " + a.getQuizName());
			if (a.getScore() != -1) 
				System.out.println("Score: " + a.getScore());
			System.out.println("Date " + a.getDate());
			if (a.getDuration() != -1) 
				System.out.println("Duration :" + a.getDuration());
		}

	}



	@Test
	public void testGetFriendRequests() {
		Connection conn = MyDB.getConnection(); 
		User user = new User();
		User.purgeFriendsTable(); 
		User.purgeUsersTable(); 
		User.purgeMessagesTable(); 
		try {
			Statement stmt = conn.createStatement();

			java.util.Date dt = new java.util.Date();

			java.text.SimpleDateFormat sdf = 
					new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			String currentTime = sdf.format(dt);
			String query = "INSERT INTO Friend VALUES(\"kuda\", \"rupa\", " + false + ", '" + currentTime + "'" + ")";
			stmt.executeUpdate(query); 
			query = "INSERT INTO Friend VALUES(\"ryan\", \"rupa\", false, " + "'" + currentTime + "'" + ")";
			stmt.executeUpdate(query); 
			query = "INSERT INTO Friend VALUES(\"kuda\", \"mailyn\", false, " + "'" + currentTime + "'" + ")";
		}
		catch(SQLException e) {
			e.printStackTrace(); 
		}

		user.addUser("rupa", "password"); 
		ArrayList<FriendRequest> friendRequests = user.getFriendRequests(); 
		assertEquals(2, friendRequests.size()); 
		boolean kuda = false; 
		boolean ryan = false; 
		for (FriendRequest f : friendRequests) {
			if (f.getFromUsername().equals("kuda")) { 
				kuda = true; 
			}
			if (f.getFromUsername().equals("ryan")) { 
				ryan = true; 
			}
		}
		assertTrue(ryan); 
		assertTrue(kuda); 

	}



}

