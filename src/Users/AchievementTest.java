package Users;

import static org.junit.Assert.assertTrue;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.junit.Test;

import quiz.Quiz;
import database.MyDB;

public class AchievementTest {

	/*
	 * This test checks for the add achievement and getachievement methods 
	 * */

	public User user = null;

	public void createUser(){
		user = new User();
		user.addUser("minnie", "lennon");	
	}


	@Test
	public void testForAddingAwards(){
		User.purgeQuizTable();
		User.purgeAchievementsTable();

		createUser();
		user = User.getUser("minnie");

		ArrayList<Quiz> empty = user.getQuizCreated();
		assertTrue(empty.size() == 0);
		
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("insert into Quiz (username, timeCreated, name, description, randomOrder, multiplePages, immediateCorrection, practiceMode) values ('minnie', NULL, 'Disney', 'All the songs!', false, false, false, false);");
			stmt.executeUpdate("insert into Quiz (username, timeCreated, name, description, randomOrder, multiplePages, immediateCorrection, practiceMode) values ('minnie', NULL, 'Mice', 'Scientific facts about mice', false, false, false, false);");
			stmt.executeUpdate("insert into Quiz (username, timeCreated, name, description, randomOrder, multiplePages, immediateCorrection, practiceMode) values ('minnie', NULL, 'Mice Vacations', 'All the places mice like to go', false, false, false, false);");
			stmt.executeUpdate("insert into Quiz (username, timeCreated, name, description, randomOrder, multiplePages, immediateCorrection, practiceMode) values ('minnie', NULL, 'Mice a history', 'Mice and other animals', false, false, false, false);");
			stmt.executeUpdate("insert into Quiz (username, timeCreated, name, description, randomOrder, multiplePages, immediateCorrection, practiceMode) values ('minnie', NULL, 'Of Mice and Men', 'Mice and other animals', false, false, false, false);");
		} catch (SQLException e) {
			e.printStackTrace(); 
		}

		ArrayList<Quiz> qc = user.getQuizCreated();
		assertTrue(qc.size() == 5);

		user.awardAchievement(Achievement.PROLIFIC_AUTHOR);
		ArrayList <String> testAchievements = new ArrayList<String>();

		testAchievements.add(Achievement.PROLIFIC_AUTHOR);
		ArrayList <String> achievements = user.getAchievements();

		assertTrue(achievements.size() == 1);
		assertTrue(achievements.equals(testAchievements));
	}

	@Test
	public void testForGreatest(){
		User.purgeQuizTable();
		User.purgeAchievementsTable();
		
		 createUser();
		 user = User.getUser("minnie");

		
		user.awardAchievement(Achievement.I_AM_THE_GREATEST);
		ArrayList <String> testAchievements = new ArrayList<String>();

		testAchievements.add(Achievement.I_AM_THE_GREATEST);
		ArrayList <String> achievements = user.getAchievements();

		assertTrue(achievements.size() == 1);
		assertTrue(achievements.equals(testAchievements));
	}

	@Test
	public void testForAmateur(){
		User.purgeQuizTable();
		User.purgeAchievementsTable();

		createUser();
		user = User.getUser("minnie");

		 
		ArrayList<Quiz> empty = user.getQuizCreated();
		assertTrue(empty.size() == 0);
		
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			for (int i = 0; i < 1; i++) {
				String sqlStr = "insert into Quiz (username, timeCreated, name, description, randomOrder, multiplePages, immediateCorrection, practiceMode) values ('minnie', NULL, 'Disney" + i + "'"+", 'All the songs!', false, false, false, false)";
				stmt.executeUpdate(sqlStr);
			}
		} catch (SQLException e) {
			e.printStackTrace(); 
		}


		ArrayList<Quiz> qc = user.getQuizCreated();
		assertTrue(qc.size() == 1);

		user.awardAchievement(Achievement.AMATEUR_AUTHOR);
		ArrayList <String> testAchievements = new ArrayList<String>();
		
		ArrayList <String> achievements = user.getAchievements();
			
 		testAchievements.add(Achievement.AMATEUR_AUTHOR);
		assertTrue(achievements.size() == 1);
		assertTrue(achievements.equals(testAchievements));
	}

	@Test
	public void testForProdigious(){
		User.purgeQuizTable();
		User.purgeAchievementsTable();

		createUser();
		user = User.getUser("minnie");

		 
		ArrayList<Quiz> empty = user.getQuizCreated();
		assertTrue(empty.size() == 0);
		
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			for (int i = 0; i < 10; i++) {
				String sqlStr = "insert into Quiz (username, timeCreated, name, description, randomOrder, multiplePages, immediateCorrection, practiceMode) values ('minnie', NULL, 'Disney" + i + "'"+", 'All the songs!', false, false, false, false)";
				stmt.executeUpdate(sqlStr);
			}
		} catch (SQLException e) {
			e.printStackTrace(); 
		}


		ArrayList<Quiz> qc = user.getQuizCreated();
		assertTrue(qc.size() == 10);

		user.awardAchievement(Achievement.PRODIGIOUS_AUTHOR);
		ArrayList <String> testAchievements = new ArrayList<String>();
		
		ArrayList <String> achievements = user.getAchievements();
			
 		testAchievements.add(Achievement.PRODIGIOUS_AUTHOR);
		assertTrue(achievements.size() == 1);
		assertTrue(achievements.equals(testAchievements));
	}
	
	@Test
	public void testForIAmTheGreatest(){
		User.purgeQuizTable();
		User.purgeAchievementsTable();
		
		createUser();
		user = User.getUser("minnie");
		
		user.awardAchievement(Achievement.I_AM_THE_GREATEST);
		ArrayList<String> achievements = user.getAchievements();
		
		ArrayList <String> testAchievements = new ArrayList<String>();
		testAchievements.add(Achievement.I_AM_THE_GREATEST);
		
		assertTrue(achievements.equals(testAchievements));	
	}
	
	@Test
	public void testForPracticeMakesPerfect(){
		User.purgeAchievementsTable();
		User.purgeUsersTable();
		User.purgeTookQuiz();
		
		createUser();
		user = User.getUser("minnie");
		
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			for (int i = 0; i < 1; i++) {
				String sqlStr = "insert into TookQuiz (quizID, username, score, time, duration, practiceMode) values " +
													  "(1, 'minnie', 10 , '1984-10-27 02:10:00',10 , true)";
				stmt.executeUpdate(sqlStr);
			}
		} catch (SQLException e) {
			e.printStackTrace(); 
		}
		
		user.awardAchievement(Achievement.PRACTICE_MAKES_PERFECT);
		
		ArrayList <String> testAchievements = new ArrayList<String>();
		testAchievements.add(Achievement.PRACTICE_MAKES_PERFECT);
		
		ArrayList<String> achievements = user.getAchievements();
		
		assertTrue(achievements.equals(testAchievements));
	}

	@Test
	public void testMultipleAwards(){
		User.purgeQuizTable();
		User.purgeAchievementsTable();
		User.purgeTookQuiz();
		
		createUser();
		user = User.getUser("minnie");
		
		user.awardAchievement(Achievement.I_AM_THE_GREATEST);
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("insert into Quiz (username, timeCreated, name, description, randomOrder, multiplePages, immediateCorrection, practiceMode) values ('minnie', NULL, 'Disney', 'All the songs!', false, false, false, false);");
			stmt.executeUpdate("insert into Quiz (username, timeCreated, name, description, randomOrder, multiplePages, immediateCorrection, practiceMode) values ('minnie', NULL, 'Mice', 'Scientific facts about mice', false, false, false, false);");
			stmt.executeUpdate("insert into Quiz (username, timeCreated, name, description, randomOrder, multiplePages, immediateCorrection, practiceMode) values ('minnie', NULL, 'Mice Vacations', 'All the places mice like to go', false, false, false, false);");
			stmt.executeUpdate("insert into Quiz (username, timeCreated, name, description, randomOrder, multiplePages, immediateCorrection, practiceMode) values ('minnie', NULL, 'Mice a history', 'Mice and other animals', false, false, false, false);");
			stmt.executeUpdate("insert into Quiz (username, timeCreated, name, description, randomOrder, multiplePages, immediateCorrection, practiceMode) values ('minnie', NULL, 'Of Mice and Men', 'Mice and other animals', false, false, false, false);");
		} catch (SQLException e) {
			e.printStackTrace(); 
		}

		user.awardAchievement(Achievement.PROLIFIC_AUTHOR);

		ArrayList <String> testAchievements = new ArrayList<String>();
		testAchievements.add(Achievement.I_AM_THE_GREATEST);
		testAchievements.add(Achievement.PROLIFIC_AUTHOR);


		ArrayList<String> achievements = user.getAchievements();
		assertTrue(achievements.equals(testAchievements));

	}
}
