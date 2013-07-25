package Users;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import quiz.AbstractQuestion;
import quiz.Quiz;
import quiz.QuizTaken;
import database.MyDB;


/*
 * ATTRIBUTION:
 * Code for passsword salt is based on a tutorial from:
 * https://www.owasp.org/index.php/Hashing_Java#Why_add_salt_.3F
 * */
public class User{

	private String username = "";
	private Connection conn = null;
	private ArrayList<String> friends;
	private ArrayList<String> achievements;
	private ArrayList<Challenge> challenges; 
	private ArrayList<FriendRequest> friendRequests; 
	private ArrayList<Note> notes;
	private final static int Num_encrypt_iterations = 1000;

	public User(){
		friends = new ArrayList<String>();
		achievements = new ArrayList<String>();
		challenges = new ArrayList<Challenge>(); 
		friendRequests = new ArrayList<FriendRequest>(); 
		notes = new ArrayList<Note>();
	}

	/**
	 * Creates a new user object with the specified username.
	 * Note that this username has not yet been added to the database
	 * You must still call addUser on this object;
	 * 
	 * */
	public User(String username){
		friends = new ArrayList<String>();
		achievements = new ArrayList<String>();
		challenges = new ArrayList<Challenge>(); 
		friendRequests = new ArrayList<FriendRequest>(); 
		notes = new ArrayList<Note>();

		this.username = username;
	}

	/**
	 * This method creates a new user object if the specified username exists,
	 * Otherwise it returns null. You must call the constructor before calling this method
	 * because we don't wanna break things :)
	 * @author lennon
	 * @param - username -- String
	 * @return User object.
	 * */
	public static User getUser(String username){
		if(userExists(username)){
			User user = new User(username);
			return user;
		}
		return null;
	}

	/**
	 * This is a convenience method in case we need to purge the user database
	 * This should never be called, (except for tearing down test)
	 * */
	public static void purgeUsersTable(){
		String strSQL = "TRUNCATE TABLE User";
		Connection con = MyDB.getConnection();
		try{
			Statement stmt = con.createStatement();
			stmt.executeUpdate(strSQL);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}


	public static void purgeTookQuiz(){
		String strSQL = "TRUNCATE TABLE TookQuiz";
		Connection con = MyDB.getConnection();
		try{
			Statement stmt = con.createStatement();
			stmt.executeUpdate(strSQL);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}

	/**
	 * This is a convenience method in case we need to purge the user database
	 * This should never be called, (except for tearing down test)
	 * */
	public static void purgeAchievementsTable(){
		String strSQL = "TRUNCATE TABLE Achievements";
		Connection con = MyDB.getConnection();
		try{
			Statement stmt = con.createStatement();
			stmt.executeUpdate(strSQL);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}

	public static void purgeQuizTable(){
		String strSQL = "TRUNCATE TABLE Quiz";
		Connection con = MyDB.getConnection();
		try{
			Statement stmt = con.createStatement();
			stmt.executeUpdate(strSQL);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}

	/**
	 * This is a convenience method in case we need to purge the user database
	 * This should never be called, (except for tearing down test)
	 * */
	public static void purgeFriendsTable(){
		String strSQL = "TRUNCATE TABLE Friend";
		Connection con = MyDB.getConnection();
		try{
			Statement stmt = con.createStatement();
			stmt.executeUpdate(strSQL);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}

	public static void purgeMessagesTable(){
		String strSQL = "TRUNCATE TABLE Messages";
		Connection con = MyDB.getConnection();
		try{
			Statement stmt = con.createStatement();
			stmt.executeUpdate(strSQL);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}

	/**
	 *	Adds a new user to the database.
	 *	@param username String
	 *	@param password String
	 *	@return true if the user has been successfully added,
	 *			false if the user name already exists or something
	 *			really bad happens. We'll get to that :) 
	 */
	public boolean addUser(String username, String password){

		
		String cryptedPass = "";
		String sSalt = "";

		conn = MyDB.getConnection();
		try{
			if (userExists(username)){
				return false;
			}

			SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
			byte[] bSalt = new byte[8];
			random.nextBytes(bSalt);
			
			byte[] cryptedArray = encryptPassword(Num_encrypt_iterations,password,bSalt);
			cryptedPass = hexToString(cryptedArray);
			sSalt = hexToString(bSalt);

			String strSQL = "INSERT INTO User (username, password, isAdmin, salt) VALUES (?, ?, ?, ?)";
			PreparedStatement stmt = conn.prepareStatement(strSQL);

			stmt.setString(1, username);
			stmt.setString(2, cryptedPass);
			stmt.setBoolean(3, false);
			stmt.setString(4, sSalt);

			stmt.executeUpdate();

		}catch(SQLException e){
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		this.username = username;
		return true;
	}

	/**
	 * Initial getter for username.
	 * Mailyn needs this to test her code.
	 * We can change this.
	 * @String - username
	 * @author - mfidler
	 */
	public String getUsername() {
		return username;
	}
	
	/**
	 * Returns a List of all Deleted Users in the database.
	 * @return A list of all deleted users. null if there is a SQL error
	 * @author jujh
	 */
	public static User[] getDeletedUsers() {
		Connection conn = MyDB.getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("select username from DeletedUser");
			ResultSet results = stmt.executeQuery();
			List<User> allUsers = new ArrayList<User>();
			while (results.next()) {
				allUsers.add(new User(results.getString("username")));
			}
			return allUsers.toArray(new User[allUsers.size()]);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}	
	/**
	 * Checks to see if the given name is in the deletedUser database.
	 * @param username
	 * @return if the name exists
	 * @author jujh
	 */
	public static boolean isDeletedUser(String username)
	{
		String strSQL = "SELECT * FROM DeletedUser WHERE username=?";
		int numRows = 0;
		Connection conn = MyDB.getConnection();
		try{
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			
			rs.last();
			numRows = rs.getRow();

		}catch(SQLException e){
			e.printStackTrace();
		}
		return (numRows > 0);
	}

	/**
	Checks if the username already exists.
	Call this method from Servlet when creating a new user account
	@param username - String
	@return true if the username is already in the database

	 */
	public static boolean userExists(String username){
		String strSQL = "SELECT * FROM User WHERE username = ? "+
				"UNION SELECT * FROM DeletedUser WHERE username = ? ";
		int numRows = 0;
		Connection conn = MyDB.getConnection();
		try{
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setString(1, username);
			stmt.setString(2, username);
			ResultSet rs = stmt.executeQuery();

			rs.last();
			numRows = rs.getRow();

		}catch(SQLException e){
			e.printStackTrace();
		}
		return (numRows > 0);
	}


	/**
	Checks to see if a user login is valid
	@param username - String
	@param password - String which is a plain text version of the password
	@return true if a user is authenticated
	@author lennon
	 */
	public static boolean isValidLogin(String username, String password){

		byte[] loginCredentials = null;
		byte[] cryptedPass = null;
		Connection conn = MyDB.getConnection();
		
		try{
			String strSQL = "SELECT password, salt FROM User WHERE username = ?";
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			
			String pass = "";
			String salt = "";
			
			if(rs.next()){
				pass = rs.getString("password");
				salt = rs.getString("salt");
				if (pass == null || salt == null) {
					return false;
				}
			}
			cryptedPass = hexToArray(pass);
			byte[] bSalt = hexToArray(salt);

			loginCredentials = encryptPassword(Num_encrypt_iterations, password, bSalt);
			return Arrays.equals(loginCredentials, cryptedPass);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return Arrays.equals(loginCredentials, cryptedPass);
	}

	
	public ArrayList<String> getAchievements() {
		return getAchievements(this.username);
	}
	/**
	 * Gets achievements that the user's had so far
	 * @return achievements - an arraylist of achievement objects
	 * @author Lennon/mfidler -> changes
	 * */
	public ArrayList<String> getAchievements(String username){
		ArrayList<String> achievements = new ArrayList<String>();
		String strSQL = "SELECT * FROM Achievements WHERE username = " + "?";
		try{
			conn = MyDB.getConnection();
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			
			stmt.setString(1, username);

			ResultSet rs = stmt.executeQuery();

			while(rs.next()){
				String type = rs.getString("type");
				if (!achievements.contains(type)){
					achievements.add(type);
				}
				
			}
		}catch(SQLException e){
			e.printStackTrace();
		}

		return achievements;
	}

	/*
	 * Deletes the challenges for a given quizID, if any exist. 
	 * @author Rupa
	 */
	
	public void deleteChallenges(int quizID) {
		conn = MyDB.getConnection();
		String query = "delete from Messages where quizID = ? and type = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setInt(1, quizID);
			stmt.setString(2,  "challenge");
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	/** 
	 * Returns challenges that the current user has received. 
	 * @author Rupa
	 */
	public ArrayList<Challenge> getChallenges(){
		challenges.clear(); 
		conn = MyDB.getConnection(); 
		try {
			// challenge
			String query = "SELECT fromUsername, quizID, time FROM Messages WHERE type= ? AND toUserName = ? ORDER BY time desc";
			PreparedStatement stmt = conn.prepareStatement(query); 

			stmt.setString(1, "challenge");
			stmt.setString(2, username);

			ResultSet set = stmt.executeQuery(); 
			while (set.next()) {
				challenges.add(new Challenge(set.getString("fromUserName"), this.username, set.getInt("quizID"), set.getString("time"))); 
			}
		}
		catch(SQLException e) {
			e.printStackTrace(); 
		}

		return challenges; 

	}
	/**
	 * @author Rupa
	 */
	public ArrayList<FriendRequest> getFriendRequests() {
		friendRequests.clear(); 
		conn = MyDB.getConnection(); 
		try {
			String query = "SELECT friend1, time FROM Friend WHERE friend2 = ?  AND status=false order by time desc";
			PreparedStatement stmt = conn.prepareStatement(query); 
			stmt.setString(1, username);
			ResultSet set = stmt.executeQuery(); 
			while (set.next()) {
				friendRequests.add(new FriendRequest(set.getString("friend1"), this.username, set.getString("time")));  
			}
		}
		catch(SQLException e) {
			e.printStackTrace(); 
		}
		return friendRequests; 
	}

	/**
	 * Returns an array list of Activity objects.  This represents
	 * all quizzes taken or created by all friends, with each friend's activities
	 * ordered by time.
	 * @return ArrayList<Quiz> - of all activity of friends
	 * @author mfidler
	 */
	public ArrayList<Activity> getFriendActivity() {
		ArrayList<Activity> friendActivity = new ArrayList<Activity>();
		ArrayList<String> friends = this.getFriends();
		for (String name : friends) {
			ArrayList<QuizTaken> taken = getTaken(name);
			for (QuizTaken qt : taken) {
				Activity a = new Activity(qt);
				friendActivity.add(a);
			}
			ArrayList<Quiz> qc = getCreated(name);
			for (Quiz qz : qc) {
				Activity a = new Activity(qz);
				friendActivity.add(a);
			}
		}
		return friendActivity;
	}
	
	public HashMap<String, ArrayList<String>> getFriendAchievements() {
		HashMap<String, ArrayList<String>> friendAchievements = new HashMap<String, ArrayList<String>>();
		ArrayList<String> friends = this.getFriends();
		for (String f : friends) {
			ArrayList<String> achs = new ArrayList<String>();
			achs = getAchievements(f);
			friendAchievements.put(f, achs);
		}
		return friendAchievements;
	}

	/**
	 * Returns a list of quizzes the user has taken ordered by time.
	 * @return ArrayList<QuizTaken> quizzes taken
	 * @author mfidler
	 */
	public ArrayList<QuizTaken> getQuizHistory(){
		ArrayList<QuizTaken> quizzesTaken = getTaken(this.username);
		return quizzesTaken;
	}

	/**
	 * Gets a list of the quizzes the user has created ordred by time.
	 * @return ArrayList<Quiz> quizzes created
	 * @author mfidler
	 */
	public ArrayList<Quiz> getQuizCreated(){
		ArrayList<Quiz> quizzesCreated = getCreated(this.username);
		return quizzesCreated;
	}
	
	/**
	 * Returns this user's highest score.
	 * @return - double, highScore. -1 if no scores
	 * @author - mfidler
	 */
	public double getHighestScore() {
		double highScore = -1.0;
		String cmd = "SELECT * FROM TookQuiz WHERE username = '" + this.username + "' order by score desc, duration asc limit 1";
		try {
			PreparedStatement stmt  = conn.prepareStatement(cmd);
			ResultSet rs = stmt.executeQuery(); 
			while (rs.next()) {
				highScore = rs.getDouble(3);
			}
		} catch(SQLException e) {
			e.printStackTrace(); 
		}
		return highScore;
	}

	/**
	 * Gets a list of a given user's friend
	 * @author lennon
	 * @return arrayList of userId's that a particular user is friends with.
	 * */
	public ArrayList<String> getFriends(){

		ArrayList<String> friends = new ArrayList<String>(); 
		conn = MyDB.getConnection(); 
		try {
			String query = "SELECT friend1 FROM Friend WHERE friend2 = ? AND status = true "; 
			query += "UNION SELECT friend2 FROM Friend WHERE friend1 = ? AND status = true ";
			PreparedStatement stmt = conn.prepareStatement(query);
			
			stmt.setString(1, this.username);
			stmt.setString(2, this.username);
			ResultSet set = stmt.executeQuery();

			while (set.next()) {
				friends.add(set.getString("friend1")); 
			}

		}
		catch (SQLException e) {
			e.printStackTrace(); 
		}
		return friends; //returns an empty ArrayList if there are no friends

	}

	/**
	 * Changes the users administrator status.
	 * @param admin - boolean
	 * @author lennon
	 */
	public void setAdmin(boolean admin) {
		// set field in database to true or false
		String strSQL = "UPDATE User SET isAdmin = " + "?" + " WHERE username = " + "?";
		Connection conn = MyDB.getConnection(); 
		try {
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			
			stmt.setBoolean(1, admin);
			stmt.setString(2, this.username);
			
			stmt.executeUpdate();
		}catch (SQLException e){
			e.printStackTrace();
		}
	}

	/**
	 * Determines if user has administrative status.
	 * @return true - if user is administrator
	 * @return false - if user is not administrator
	 */
	public boolean isAdmin() {

		boolean isAdmin = false;
		conn = MyDB.getConnection();
		String strSQL = "Select isAdmin from User where username = ?";

		try{
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setString(1, this.username);
			ResultSet rs = stmt.executeQuery();

			rs.first();
			isAdmin = rs.getBoolean("isAdmin");
		}catch(SQLException e){
			e.printStackTrace();
		}
		return isAdmin;
	}

	// NOTE: THESE MAYBE SHOULD BE DONE USING FR/CHALLENGE OBJECTS
	/**
	 * Sends a friend request from current user to a recipient.
	 * @param recipientID - String
	 */
	void sendFriendRequest(String recipientID) {
		conn = MyDB.getConnection();
		if (!hasPendingFriendshipWith(recipientID)){
            try{
                Date dt = new Date();

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                String currentTime = sdf.format(dt);
                String strSQL1 = "INSERT INTO Friend (friend1, friend2, status, time) VALUES (?, ?, ?, ?)";

                PreparedStatement stmt = conn.prepareStatement(strSQL1);
                stmt.setString(1, this.username);
                stmt.setString(2, recipientID);
                stmt.setBoolean(3, false);
                stmt.setString(4,  currentTime);
                stmt.executeUpdate();

            }catch(SQLException e){
                e.printStackTrace();
            }
		}
	}


	/**
	 * Processes a friend request. 
	 *@param accepted - boolean, true if accepted, false if rejected
	 * @param userID - String, user id of the request to which we are responding
	 */
	void processFriendRequest(boolean accepted, String userID) {
	conn = MyDB.getConnection();

        Date dt = new Date();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String currentTime = sdf.format(dt);

        try{
            PreparedStatement stmt = null;//conn.prepareStatement();
            boolean hasRequest = hasPendingFriendshipWith(userID);
            
            if (hasRequest && accepted && !(isFriendsWith(userID))){
                String strSQL = "";
                strSQL = "UPDATE Friend SET status = " + true + " WHERE friend1 = ? AND friend2= ?" ;

                stmt = conn.prepareStatement(strSQL);
                stmt.setString(1, userID);
                stmt.setString(2, this.username);
                stmt.executeUpdate();

                String strSQL2 = "INSERT INTO Friend (friend1, friend2, status, time) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(strSQL2);
                stmt.setString(1, this.username);
                stmt.setString(2, userID);
                stmt.setBoolean(3, true);
                stmt.setString(4,  currentTime);
                stmt.executeUpdate();

            }else if (!hasRequest && !isFriendsWith(userID)){
                String strSQL = "";
                strSQL = "DELETE FROM Friend WHERE friend1 = ? AND friend2=?";
                stmt = conn.prepareStatement(strSQL);
                stmt.setString(1, this.username);
                stmt.setString(2, userID);
                stmt.executeUpdate();

            }else{
                String strSQL = "";
                strSQL = "DELETE FROM Friend WHERE friend1 = ? AND friend2=?";
                stmt = conn.prepareStatement(strSQL);
                stmt.setString(1, this.username);
                stmt.setString(2, userID);
                stmt.executeUpdate();
                
                 strSQL = "DELETE FROM Friend WHERE friend1 = ? AND friend2=?";
                 stmt = conn.prepareStatement(strSQL);
                 stmt.setString(1, userID);
                 stmt.setString(2, this.username);
                 stmt.executeUpdate();
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
	}

	/**
	 * Checks to see if two people are friens
	 * @param userID - String
	 * @return true if the current user and UserID are friends
	 * */
	public boolean isFriendsWith(String userID){
		conn = MyDB.getConnection();
		boolean isFriends = false;
		try{
			
			String strSQL = "SELECT status from Friend WHERE friend1 =? AND friend2 =? ";
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setString(1, this.username);
			stmt.setString(2, userID);

			ResultSet rs = stmt.executeQuery();
			rs.last();
			if (rs.getRow() == 0){
				return false;
			}
			isFriends = rs.getBoolean("status");


		}catch(SQLException e){
			e.printStackTrace();
		}

		return isFriends;
	}

	/**
	 * Check to see if a pair of users have a pending friendship
	 * @param userID - String the user sending the friend request.
	 * @return true if there is a pending friendship request between two users
	 * @author Lennon (in case you have questions)
	 * */
	public boolean hasPendingFriendshipWith(String userID){
		int numRows = 0;
		conn = MyDB.getConnection();
		String strSQL = "SELECT * FROM Friend Where friend1 = ? AND friend2 = ? AND status = " + false;

		try {
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setString(1, userID);
			stmt.setString(2, this.username);

			ResultSet rs = stmt.executeQuery();
			numRows = 0;
			rs.last();
			numRows = rs.getRow();
			
		}catch(SQLException e){
			e.printStackTrace();
		}

		return (numRows == 0) ? false : true;
	}
	

	/**
	 * Sends a free-form text note from current user to recipient.
	 * Currently users can send notes to themselves.
	 * @param userID - String, recipient's username
	 * @param text - String
	 * @author mfidler
	 */
	void sendNote(String recipientID, String text) {
		conn = MyDB.getConnection();
		try {
			
			java.util.Date dt = new java.util.Date();

			java.text.SimpleDateFormat sdf = 
					new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			String currentTime = sdf.format(dt);
			String strSQL = "INSERT INTO Messages (fromUsername, toUsername, type, quizID, content, time, isRead) VALUES (?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setString(1, this.username);
			stmt.setString(2, recipientID);
			stmt.setString(3, "note");
			stmt.setInt(4, -1);
			stmt.setString(5, text);
			stmt.setString(6, currentTime);
			stmt.setBoolean(7, false);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	/**
	 * Retrieves messages sent to the active user.
	 * @return ArrayList<Note> getNotes() - of all notes sent TO the user
	 * @author mfidler
	 */
	
	public ArrayList<Note> getNotes() {
		notes.clear();
		conn = MyDB.getConnection(); 
		try { 
			String query = "SELECT fromUsername, quizID, content, time, isRead FROM Messages WHERE type=? AND toUserName= ? ORDER BY time desc"; 

			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, "note");
			stmt.setString(2, this.username);

			ResultSet set = stmt.executeQuery(); 
			while (set.next()) {
				notes.add(new Note(set.getString("fromUserName"), this.username, set.getInt("quizID"), set.getString("content"), set.getString("time"), set.getBoolean("isRead"))); 
			}
		}
		catch(SQLException e) {
			e.printStackTrace(); 
		}
		return notes;
	}
	
	/*
	 * @author Rupa
	 */
	public Note getIndividualNote(String fromUsername, String time) {
		conn = MyDB.getConnection();
		Note note = null;
		String query = "select * from Messages where type=? and fromUsername =? and toUsername =? and time=?";
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, "note");
			stmt.setString(2, fromUsername);
			stmt.setString(3,  this.username);
			stmt.setString(4,  time);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				note = new Note(fromUsername, this.username, rs.getInt("quizID"), rs.getString("content"), rs.getString("time"), rs.getBoolean("isRead"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return note;
	}
	
	/**
	 * @author Rupa
	 */
	public int getAnnouncementID(Announcement ann) {
		int id = -1; 
		conn = MyDB.getConnection();
		String query = "select announcementsID from Announcements where username = ? and time = ? and title = ?";
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, ann.getAuthor());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentTime = sdf.format(ann.getDate());
			stmt.setString(2, currentTime);
			stmt.setString(3, ann.getTitle());
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				id = rs.getInt("announcementsID");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return id;
	}
	 
	/**
	 * Sends a challenge message from current user to recipient.
	 * @param challengerID - String, username of recipient
	 * @param quizID - String
	 * @author Rupa
	 */
	void sendChallenge(String challengeeID, String quizID) {
		// update MESSAGES with from & to
		// set type to *challenge* and quizID to String quizID
		// set text to null
		//set time to time set
		//set read to false
		conn = MyDB.getConnection(); 
		try {
			
			Date dt = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentTime = sdf.format(dt);
			String query = "INSERT INTO Messages VALUES(?, ?,?,?,?,?,?)"; 
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, this.username);
			stmt.setString(2, challengeeID);
			stmt.setString(3, "challenge");
			stmt.setString(4, quizID);
			stmt.setString(5, "");
			stmt.setString(6, currentTime);
			stmt.setBoolean(7, false);
			stmt.executeUpdate(); 
		}
		catch(SQLException e) {
			e.printStackTrace(); 
		}
	}

	/**
	 * Checks what achievements to award to the given user
	 * 
	 * @author lennon
	 * @return ArrayList<String> with a list of new achievements awarded
	 * */
	public ArrayList<String> awardAchievement(String award){
		ArrayList<String> userAchievements = getAchievements();
		ArrayList<String> newAchieve = new ArrayList<String>();

		//if (hasEarnedPracticeMakesPerfect() && !(userAchievements.contains(Achievement.PRACTICE_MAKES_PERFECT))){
		if (award.equals(Achievement.PRACTICE_MAKES_PERFECT) && !(userAchievements.contains(Achievement.PRACTICE_MAKES_PERFECT))){
			newAchieve.add(Achievement.PRACTICE_MAKES_PERFECT);
		}

		if (hasEarnedProdigiousAuthor() && !(userAchievements.contains(Achievement.PRODIGIOUS_AUTHOR))){
			newAchieve.add(Achievement.PRODIGIOUS_AUTHOR);
		}

		if (hasEarnedProlificAuthor() && !(userAchievements.contains(Achievement.PROLIFIC_AUTHOR))){
			newAchieve.add(Achievement.PROLIFIC_AUTHOR);
		}
		
		if (hasEarnedAmateurAuthor() && !(userAchievements.contains(Achievement.AMATEUR_AUTHOR))){
			newAchieve.add(Achievement.AMATEUR_AUTHOR);
		}

		if (hasEarnedQuizMachine() && !(userAchievements.contains(Achievement.QUIZ_MACHINE))){
			newAchieve.add(Achievement.QUIZ_MACHINE);
		}

		if(award.equals(Achievement.I_AM_THE_GREATEST)){
			newAchieve.add(Achievement.I_AM_THE_GREATEST);
		}

		giveAchievements(newAchieve);
		return newAchieve;
	}

	/**
	 * Flags a specified message as read.
	 * @param fromUsername - the message sender
	 * @date_time - the date/time that the message was sent
	 * (Implicit - the message recipient is this.username)
	 * @author Rupa
	 */
	public void readMessage(String fromUsername, Date date_time)  {
		conn = MyDB.getConnection(); 
		try {
			
			java.text.SimpleDateFormat sdf = 
					new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			String msg_time = sdf.format(date_time);
			String query = "UPDATE Messages SET isRead=true WHERE fromUserName=? and toUsername=? and time=?";
			PreparedStatement stmt = conn.prepareStatement(query); 
			stmt.setString(1, fromUsername);
			stmt.setString(2, this.username);
			stmt.setString(3, msg_time);

			stmt.executeUpdate(); 
		}
		catch (SQLException e) {
			e.printStackTrace(); 
		}
		
	}
	
	
	/*
	 * Gets all the announcements that the current user can see
	 * @author Rupa
	 */
	public ArrayList<Announcement> getAnnouncements() {
		ArrayList<Announcement> announcements = new ArrayList<Announcement>(); 
		conn = MyDB.getConnection(); 
		String query = "select announcementsID, title, username, content, time from Announcements where announcementsID in (select announcementsID from UserVisibleAnnouncements where username = ?) order by time desc";
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1,  this.username); 
			ResultSet rs = stmt.executeQuery(); 
			while (rs.next()) {
				int id = rs.getInt("announcementsID");
				String title = rs.getString("title"); 
				String name = rs.getString("username"); 
				String content = rs.getString("content"); 
				String dateString = rs.getString("time"); 
				announcements.add(new Announcement(id, title, content, name, dateString)); 
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return announcements; 
	}
	
	/*
	 * Allows the current user to see the given announcementID
	 * (i.e inserts (currentUsername, announcementsID) into UserVisibleAnnouncement)
	 * @author Rupa
	 */
	
	public void insertAnnouncementForThisUser(int announcementsID) {
		String query = "INSERT INTO UserVisibleAnnouncements values(?, ?)";
		conn = MyDB.getConnection();
		PreparedStatement stmt;
		try {
			stmt = conn.prepareStatement(query);
			stmt.setString(1, this.username);
			stmt.setInt(2, announcementsID);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * Adds all announcements to UserVisibleAnnouncements for this user. 
	 * Used to preload all the current announcements for a new user. 
	 * @author Rupa
	 */
	public void addAllAnnouncements() {
		ArrayList<Announcement> announcements = User.viewAllAnnouncements();
		for (Announcement ann : announcements) {
			int annID = ann.getId();
			this.insertAnnouncementForThisUser(annID);
		}
	}
	
	/**
	 * Returns the top 5 quizzes in terms of number of times taken
	 * Some fields in the Quiz are not correct (ex: boolean flags)
	 * @author Rupa
	 */
	public Map<Quiz, Integer> getPopularQuizzes() {
		conn = MyDB.getConnection(); 
		Map<Quiz, Integer> quizCounts = new HashMap<Quiz, Integer>(); 
		String query = "select Quiz.quizID as quizID, username, timeCreated, name, description, count from Quiz, (select quizID, count(*) as count from TookQuiz group by quizID) counts where counts.quizID = Quiz.quizID limit 3";
		try {
			PreparedStatement stmt = conn.prepareStatement(query); 
			ResultSet rs = stmt.executeQuery(); 
			java.text.SimpleDateFormat sdf = 
					new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			while (rs.next()) {
				int count = rs.getInt("count"); 
				
				try {
					Quiz q = new Quiz(rs.getInt("quizID"), rs.getString("username"), new Timestamp (sdf.parse(rs.getString("timeCreated")).getTime()), rs.getString("name"), rs.getString("description"), false, false, false, false, 0);
					quizCounts.put(q,  new Integer(count)); 
					//quizCounts.put(q, count); 
				} catch (ParseException e) {
					e.printStackTrace();
				} 
			}
		}
		catch(SQLException e) {
			e.printStackTrace(); 
		}
		return quizCounts; 
		
	}
	
	/**
	 * Returns the top 3 quizzes in terms of most recently taken
	 * Note that the description field in the Quiz objects actually contains the quiz taker's username
	 * Some fields are incorrect (eg: boolean flags)
	 * @author Rupa
	 */
	public ArrayList<Quiz> getMostRecentlyTakenQuizzes() {
		conn = MyDB.getConnection(); 
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>(); 
		String query = "select * from Quiz, (select quizID, max(time) as max_time, TookQuiz.username as taker from TookQuiz group by quizID) quizTimes where Quiz.quizID = quizTimes.quizID order by max_time desc limit 3";
		try {
			PreparedStatement stmt = conn.prepareStatement(query); 
			ResultSet rs = stmt.executeQuery(); 
			java.text.SimpleDateFormat sdf = 
					new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			while (rs.next()) {
				try {
					String time = rs.getString("max_time"); 
					Date dt = sdf.parse(time);  
					Quiz q = new Quiz(rs.getInt("quizID"), rs.getString("username"), new Timestamp(dt.getTime()), rs.getString("name"), rs.getString("taker"), false, false, false, false, 0);
					//NOTE - semi "hacky" solution of setting the description field in the quiz object to be the quiz taker's username
					quizzes.add(q); 
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
		catch (SQLException e) {
			e.printStackTrace(); 
		}
		return quizzes; 
	}
	

	public AbstractQuestion getRandomQuestion() {
		int id = -1;
		conn = MyDB.getConnection(); 
		String query = "select quizID from Quiz order by rand() limit 1"; 
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			ResultSet rs = stmt.executeQuery(); 
			while (rs.next()) {
				id = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("Problem getting random quiz id");
			e.printStackTrace();
		} 
		
		query = "select orderNumber from Question where quizID = ? order by rand() limit 1";
		int orderNumber = -1;
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery(); 
			while (rs.next()) {
				orderNumber = rs.getInt("orderNumber");
			}
		} catch (SQLException e) {
			System.out.println("Problem getting random question number");
			e.printStackTrace();
		} 
		AbstractQuestion q = AbstractQuestion.readDB(id, orderNumber);
		return q;
	}
	
	/**
	 * Searches the database for the presence of a user.
	 * @return - boolean, true if the user is present
	 * @author - mfidler
	 */
	public static boolean searchForUser(String username) {
		Connection conn = MyDB.getConnection(); 
		String query = "select * from User where username = ?";
		boolean found = false;
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1,  username);
			ResultSet rs = stmt.executeQuery(); 
			if (rs.next()) {
				String person = rs.getString("username");
				if (person.equals(username)) 
					found = true;
			}
		} catch (SQLException e) {
			System.out.println("Problem finding user");
			e.printStackTrace();
		} 
		return found;
	}
	
	/**
	 * Dismisses the announcement with the given ID from the user's sight.
	 * @param announcementId
	 * @return true if success, false if SQL error
	 */
	public boolean dismissAnnouncement(int announcementId) {
		Connection con = MyDB.getConnection();
		String query = "delete from UserVisibleAnnouncements where username = ? and announcementsID = ?";
		try {
			PreparedStatement stmt = con.prepareStatement(query);
			stmt.setString(1, getUsername());
			stmt.setInt(2, announcementId);
			stmt.executeUpdate();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}


	/// ADMIN METHODS ///// ADMIN METHODS ////////// ADMIN METHODS /////////////
	
	/**
	 * Allows a user with a true isAdmin flag to create an announcement.
	 * Writes to the DB
	 * @author mfidler
	 */
	public void createAnnouncement(String title, String text) {
		if (this.isAdmin()) {
			java.util.Date dt = new java.util.Date();

			java.text.SimpleDateFormat sdf = 
					new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			String currentTime = sdf.format(dt);
			String strSQL1 = "INSERT INTO Announcements (username, time, title, content) VALUES (?, ?, ?, ?)";
			try {
				PreparedStatement stmt = conn.prepareStatement(strSQL1, Statement.RETURN_GENERATED_KEYS);
				stmt.setString(1, this.username);
				stmt.setString(2, currentTime);
				stmt.setString(3, title);
				stmt.setString(4, text);
				stmt.executeUpdate();
				ResultSet results = stmt.getGeneratedKeys();
				results.first();
				int currID = results.getInt(1);
				User[] allUsers = User.getAllUsers();
				for (int i = 0; i < allUsers.length; i++) {
					User user = allUsers[i];
					user.insertAnnouncementForThisUser(currID);
				}
				
			} catch (SQLException e) {
				e.printStackTrace(); 
			}
		}
	}
	
	/**
	 * Gets announcements that a particular admin has created.
	 * @return ArrayList<Announcement> - of announcements created by an admin
	 * @author - mfidler 
	 */
	public ArrayList<Announcement> getAdminAnnouncements() {
		ArrayList<Announcement> announcements = new ArrayList<Announcement>();
		if (this.isAdmin()) {
			String query = "SELECT announcementsID, username, time, title, content FROM Announcements WHERE username=? ORDER BY time desc"; 

			try {
				PreparedStatement stmt = conn.prepareStatement(query);
				stmt.setString(1, this.username);

				ResultSet set = stmt.executeQuery(); 
				while (set.next()) {
					announcements.add(new Announcement(set.getInt("announcementsID"), set.getString("title"), set.getString("content"), this.username,  set.getString("time"))); 
				}
			} catch(SQLException e) {
				e.printStackTrace(); 
			}
			return announcements;
		}
		return null;
	}

	
	
	/**
	 * Allows an admin to view all announcements.
	 * @return ArrayList<Announcement> - containing ALL announcements
	 * @author mfidler
	 */
	public static ArrayList<Announcement> viewAllAnnouncements() {
		ArrayList<Announcement> ancs = new ArrayList<Announcement>();
//		if (this.isAdmin()) {
		Connection conn = MyDB.getConnection();
			String query = "SELECT announcementsID, username, time, title, content FROM Announcements ORDER BY time desc"; 

			try {
				PreparedStatement stmt = conn.prepareStatement(query);

				ResultSet set = stmt.executeQuery(); 
				while (set.next()) {
					ancs.add(new Announcement(set.getInt("announcementsID"), set.getString("title"), set.getString("content"), set.getString("username"),  set.getString("time"))); 
				}
			} catch(SQLException e) {
				e.printStackTrace(); 
			}
			return ancs;
//		}
//		return null;
	}
	
	/**
	 * Sets a specified user's admin status to a specified boolean
	 * @param username - String
	 * @param admin - boolean
	 * @author - mfidler
	 */
	public void setUserAdminStatus(String username, boolean admin) {
		if (this.isAdmin()) {
			String strSQL = "UPDATE User SET isAdmin = " + "?" + " WHERE username = " + "?";
			Connection conn = MyDB.getConnection(); 
			try {
				PreparedStatement stmt = conn.prepareStatement(strSQL);
				
				stmt.setBoolean(1, admin);
				stmt.setString(2, username);
				
				stmt.executeUpdate();
			}catch (SQLException e){
				e.printStackTrace();
			}
		}
	}
	/* Adds back a user account that was deleted if the current user is an admin.
	 * This allows to user to log in and have their own page accessible by other users again.
	 * @param username - the username of the user whom we want to reactivate
	 * @author Jujh (inspired by Rupa's method below)
	 */
	public void reactivateUserAccount(String username)
	{
		if (this.isAdmin())
		{
			conn = MyDB.getConnection();
			try {
				//Get info from DeletedUser
				String query = "SELECT * FROM DeletedUser WHERE username = ?";
				PreparedStatement stmt = conn.prepareStatement(query);
				stmt.setString(1, username);
				ResultSet rs = stmt.executeQuery();
				rs.last();
				//Add to User table
				query = "INSERT INTO User VALUES(?, ?, ?, ?)";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, rs.getString("username"));
				stmt.setString(2, rs.getString("password"));
				stmt.setString(3, rs.getString("isAdmin"));
				stmt.setString(4, rs.getString("salt"));
				stmt.executeUpdate();
				//Delete from DeletedUser
				query = "DELETE FROM DeletedUser WHERE username=?";
				stmt = conn.prepareStatement(query);
				stmt.setString(1,  username); 
				stmt.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
				
		}
	}
	/* Removes a user account if the current user is an admin.  Removing a user
	 * has the following consequences:
	 * 1. the user cannot log in
	 * 2. the user page displays a "User Not Found" message, as if the user doesn't exist
	 * Both of these restrictions are lifted when an admin reactivates the user.
	 * Essentially, in our project deleting is used as a punishment of sorts,
	 * but doesn't too terribly affect the user.
	 * @param username - the username of the user whom we want to remove
	 * @author Rupa + a bit of jujh (the new stuff -> ask jujh)
	 */
	public void removeUserAccount(String username) {
		if (this.isAdmin()) {
			conn = MyDB.getConnection(); 
			try {
				//Get parameters from Users table
				String query = "SELECT * FROM User WHERE username=?";
				PreparedStatement stmt = conn.prepareStatement(query);
				stmt.setString(1, username);
				ResultSet rs = stmt.executeQuery();
				rs.last();
				//Add to DeletedUser table
				query = "INSERT INTO DeletedUser VALUES(?, ?, ?, ?)";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, rs.getString("username"));
				stmt.setString(2, rs.getString("password"));
				stmt.setString(3, rs.getString("isAdmin"));
				stmt.setString(4, rs.getString("salt"));
				stmt.executeUpdate();
				//Delete from User table
				query = "DELETE FROM User WHERE username=?";
				stmt = conn.prepareStatement(query);
				stmt.setString(1,  username); 
				stmt.executeUpdate();
			}
			catch (SQLException e) {
				e.printStackTrace(); 
			}
		}
	}
	/*
	 * Removes quiz info from the Quiz and Question tables
	 * @param quizID
	 * @author Rupa
	 */
	public static void removeQuiz(int quizID) {
//		if (this.isAdmin()) {
			Connection conn = MyDB.getConnection(); 
			String[] tablesToDeleteFrom = new String[] {"Quiz", "Question", "TookQuiz", "Messages", "QuizTags", "QuizCategories"};
			try {
				for (String table : tablesToDeleteFrom) {
					String query = "delete from " + table + " where quizID = ?";
					PreparedStatement stmt = conn.prepareStatement(query);
					stmt.setInt(1, quizID);
					stmt.executeUpdate();
				}
//				String query = "DELETE FROM Quiz WHERE quizID=?"; 
//				PreparedStatement stmt = conn.prepareStatement(query); 
//				stmt.setInt(1, quizID); 
//				stmt.executeUpdate(); 
//				query = "DELETE FROM Question WHERE quizID=?"; 
//				stmt = conn.prepareStatement(query); 
//				stmt.setInt(1,  quizID); 
//				stmt.executeUpdate(); 
//				
			}
			catch (SQLException e) {
				e.printStackTrace(); 
			}
//		}
	}
	
	/**
	 * Clears the history for a specified quiz.
	 * @param password
	 * @return
	 * @author - mfidler
	 */
	public static void clearQuizHistory(int quizID) {
			Connection conn = MyDB.getConnection(); 
			String cmd = "DELETE FROM TookQuiz WHERE quizID=?";
			try {
				PreparedStatement stmt  = conn.prepareStatement(cmd);
				stmt.setInt(1, quizID); 
				stmt.executeUpdate(); 
			} catch(SQLException e) {
				e.printStackTrace(); 
			}		
	}
	/*
	 * Returns the number of users in the User table. 
	 * Returns -1 if there is an error or if the current user is not an admin
	 * Needs to be called after setting the User object username (i.e calling addUser)
	 * @author Rupa
	 */
	public static int getTotalNumberOfUsers() {
		Connection conn = MyDB.getConnection(); 
			String query = "select * from User"; 
			try {
				PreparedStatement stmt = conn.prepareStatement(query); 
				ResultSet rs = stmt.executeQuery(); 
				rs.last(); 
				return rs.getRow(); 
			}
			catch (SQLException e) {
				e.printStackTrace(); 
			}
			
		return -1; 
	}
	
	/**
	 * Returns a List of all Users in the database.
	 * @return A list of all users. null if there is a SQL error
	 */
	public static User[] getAllUsers() {
		Connection conn = MyDB.getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement("select username from User");
			ResultSet results = stmt.executeQuery();
			List<User> allUsers = new ArrayList<User>();
			while (results.next()) {
				allUsers.add(new User(results.getString("username")));
			}
			return allUsers.toArray(new User[allUsers.size()]);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/*
	 * 
	 * @author RupJar
	 */
	
	public static ArrayList<Quiz> getTopThreeRecentlyCreatedQuizzes() {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>(); 
		Connection conn = MyDB.getConnection();
		String query = "select * from Quiz order by timeCreated desc limit 3";
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Quiz q = Quiz.readDB(rs.getInt("quizID"));
				quizzes.add(q); 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quizzes;
	}
	
	public static Map<String, Integer> getTopThreeQuizTakers() {
		Map<String, Integer> map = new HashMap<String, Integer>(); 
		Connection conn = MyDB.getConnection();
		String query = "SELECT username, count from (SELECT username, count(*) as count FROM TookQuiz GROUP BY username) counts ORDER BY count desc limit 3;";
		
		
		try {
			PreparedStatement stmt = conn.prepareStatement(query);
			ResultSet rs = stmt.executeQuery(); 
			while (rs.next()) {
				String name = rs.getString("username"); 
				int count = rs.getInt("count"); 
				map.put(name, count);  
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return map; 
	}
	
	/**
	 * Returns total number of quizzes taken, ever.
	 * For admin.
	 * @return int - total number of quizzes taken
	 * @author - mfidler
	 */
	public static int getTotalQuizzesTaken() {
//		if (this.isAdmin()) {
		Connection conn = MyDB.getConnection();
			int quizzesTaken = -1;
			String cmd = "SELECT * FROM TookQuiz";
			try {
				PreparedStatement stmt  = conn.prepareStatement(cmd);
				ResultSet rs = stmt.executeQuery(); 
				rs.last();
				quizzesTaken = rs.getRow();
			} catch(SQLException e) {
				e.printStackTrace(); 
			}
			
			return quizzesTaken;
//		}
//		return -1;
	}
	
	/**
	 * Returns top three scorers ever, by score and duration.
	 * @return ArrayList<QuizTaken> 
	 * @author Rylyn
	 */
	public static ArrayList<QuizTaken> getTopThreeScores() {
		
		Connection conn = MyDB.getConnection();
		ArrayList<QuizTaken> scores = new ArrayList<QuizTaken>();
//		if (this.isAdmin()) {
			String cmd = "SELECT * FROM TookQuiz order by score desc, duration asc limit 3";
			try {
				PreparedStatement stmt  = conn.prepareStatement(cmd);
				ResultSet rs = stmt.executeQuery(); 
				while (rs.next()) {
					QuizTaken qt = new QuizTaken(rs.getInt("quizID"), rs.getString("username"), rs.getDouble("score"), rs.getTimestamp("time"), rs.getInt("duration"));
					scores.add(qt);
				}
			} catch(SQLException e) {
				e.printStackTrace(); 
			}
//		}
		return scores;
	}
	
	/**
	 * Returns an array list of strings of the top quiz creators.
	 * @return ArrayList<String>
	 * @author - Rylyn
	 */
	public static ArrayList<String>  getProlificCreators() {
		
		ArrayList<String> creators = new ArrayList<String>();
//		if (this.isAdmin()) {
		Connection conn = MyDB.getConnection();
			String cmd = "SELECT DISTINCT username FROM (select username, count(*) as numCreated from  Quiz group by username) pairs order by numCreated desc limit 3";
			try {
				PreparedStatement stmt  = conn.prepareStatement(cmd);
				ResultSet rs = stmt.executeQuery(); 
				while (rs.next()) {
					String s = rs.getString("username");
					creators.add(s);
				}
			} catch(SQLException e) {
				e.printStackTrace(); 
			}
			
			
			
//		}
		return creators;
	}
		
	

	//// PRIVATE METHODS /////// PRIVATE METHODS //////// PRIVATE METHODS //////////


	/*
	 * Encrypts the user password and salt
	 * */
	private static byte[] encryptPassword(int iterationNb, String password, byte[] salt){
		byte [] input = null;
		try{
			MessageDigest crypt = MessageDigest.getInstance("SHA-1");
			crypt.reset();
			crypt.update(salt);
			input = crypt.digest(password.getBytes("UTF-8"));
			for (int i = 0; i < iterationNb; i++) {
				crypt.reset();
				input = crypt.digest(input);
			}
			return input;
		}catch(NoSuchAlgorithmException e){
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return input;
	}

	/*
	 Given a byte[] array, produces a hex String,
	 such as "234a6f". with 2 chars for each byte in the array.
	 (provided code)
	 */
	private static String hexToString(byte[] bytes) {
		StringBuffer buff = new StringBuffer();
		for (int i=0; i<bytes.length; i++) {
			int val = bytes[i];
			val = val & 0xff;  // remove higher bits, sign
			if (val<16) buff.append('0'); // leading 0
			buff.append(Integer.toString(val, 16));
		}
		return buff.toString();
	}

	/*
	 Given a string of hex byte values such as "24a26f", creates
	 a byte[] array of those values, one byte value -128..127
	 for each 2 chars.
	 (provided code)
	 */
	private static byte[] hexToArray(String hex) {
		byte[] result = new byte[hex.length()/2];
		for (int i=0; i<hex.length(); i+=2) {
			result[i/2] = (byte) Integer.parseInt(hex.substring(i, i+2), 16);
		}
		return result;
	}

	/**
	 * Checks the database to see whether or not a user
	 * was awarded the prolific author award
	 * @return true if user has earned that award
	 * @author lennon
	 * */
	private boolean hasEarnedProlificAuthor(){
		int numQuizzesCreated = checkNumQuizzesCreated();
		return (numQuizzesCreated >= 5 && numQuizzesCreated < 10);
	}
	
	/**
	 * Checks the database to see whether or not a user
	 * was awarded the amateur author award
	 * @return true if user has earned that award
	 * @author lennon
	 * */
	private boolean hasEarnedAmateurAuthor(){
		int numQuizzesCreated = checkNumQuizzesCreated();
		return (numQuizzesCreated >= 1 && numQuizzesCreated < 5);
	}

	/**
	 * Checks the database to see whether or not a user
	 * was awarded the prolific author award
	 * @return true if user has earned that award
	 * @author lennon
	 * */
	private boolean hasEarnedProdigiousAuthor(){
//		ArrayList<QuizTaken> taken = getTaken(this.username);
		int numQuizzesCreated = checkNumQuizzesCreated();
		return (numQuizzesCreated >= 10);
	}

	/**
	 * Checks to see if the user has earned practice mode
	 * @return true if the user has earned the Practice Makes Perfect Achievement
	 * @author lennon
	 * */
	private boolean hasEarnedPracticeMakesPerfect(){
		String strSQL = "Select * from TookQuiz where username = ? AND practiceMode = true";

		int numRows = 0;
		try{
			Connection conn = MyDB.getConnection();
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setString(1, this.username);
			ResultSet rs = stmt.executeQuery();
			rs.last();
			numRows = rs.getRow();
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}
		return (numRows > 0);
	}

	/**
	 * Check if a user has earned a the elusive quiz machine achievement
	 * @return true if user has the quiz machine achievement
	 * @author lennon
	 * */
	private boolean hasEarnedQuizMachine(){
		int numQuizzesTaken = checkNumQuizzesTaken();
		return numQuizzesTaken >= 10;
	}

	/**
	 * Convenience method for checking how many quizzes someone has created
	 * @author lennon
	 * @return numQuizzesCreated - int
	 * */
	private int checkNumQuizzesCreated(){
		//Basically we check if the count of the quizzes created is greater than 5
		String strSQL = "Select * from Quiz where username =?";

		try {
			conn = MyDB.getConnection();
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setString(1, this.username);
			ResultSet rs = stmt.executeQuery();
			rs.last();

			return rs.getRow();

		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}

	/**
	 * Convenience method for checking how many quizzes someone has taken
	 * @author lennon
	 * @return numQuizzesCreated - int
	 * */
	private int checkNumQuizzesTaken(){
		//Basically we check if the count of the quizzes created is greater than 5
		String strSQL = "Select * from TookQuiz where username = ?";

		try {
			conn = MyDB.getConnection();
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setString(1, this.username);

			ResultSet rs = stmt.executeQuery();
			rs.last();

			return rs.getRow();

		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}

	private void giveAchievements(ArrayList<String> newAchieve){
		conn = MyDB.getConnection();

		try {
			
			for(int i = 0; i < newAchieve.size(); i++){
				String strSQL = "Insert into Achievements (username, type) VALUES (?, ?)";
				String type = newAchieve.get(i);
				PreparedStatement stmt = conn.prepareStatement(strSQL);
				stmt.setString(1, this.username);
				stmt.setString(2, type);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * Private helper, returns a list of quizzes the user has taken ordered by time.
	 * @return ArrayList<QuizTaken> quizzes taken
	 * @author mfidler
	 */
	private ArrayList<QuizTaken> getTaken(String username) {
		ArrayList<QuizTaken> quizzesCreated = new ArrayList<QuizTaken>();
		String strSQL = "SELECT * FROM TookQuiz Where username = ? AND practiceMode = false order by time desc";
		conn = MyDB.getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Integer quizID = (Integer) rs.getObject(1);
				String uname = (String) rs.getObject(2);
				Timestamp time = (Timestamp) rs.getObject(4);
				QuizTaken qt = QuizTaken.readDB(quizID, uname, time);
				quizzesCreated.add(qt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quizzesCreated;
	}
	
	/**
	 * Private helper, gets a list of the quizzes the user has created ordred by time.
	 * @return ArrayList<Quiz> quizzes created
	 * @author mfidler
	 */
	private ArrayList<Quiz> getCreated(String username) {
		ArrayList<Quiz> quizzesCreated = new ArrayList<Quiz>();
		String strSQL = "SELECT * FROM Quiz Where username = ? order by timeCreated desc";
		conn = MyDB.getConnection();
		try {
			PreparedStatement stmt = conn.prepareStatement(strSQL);
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Integer quizID = (Integer) rs.getObject(1);
				Quiz quiz = Quiz.readDB(quizID);
				quizzesCreated.add(quiz);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quizzesCreated;
	}
	
}


