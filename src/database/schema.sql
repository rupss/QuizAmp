USE c_cs108_rglobus
-- replace with your own database name

DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Friend;
DROP TABLE IF EXISTS TookQuiz;
DROP TABLE IF EXISTS Messages;
DROP TABLE IF EXISTS Announcements;
DROP TABLE IF EXISTS UserVisibleAnnouncements;
DROP TABLE IF EXISTS Achievements;
DROP TABLE IF EXISTS Quiz;
DROP TABLE IF EXISTS Question;
DROP TABLE IF EXISTS DeletedUser;
DROP TABLE IF EXISTS QuizTags;
DROP TABLE IF EXISTS QuizCategories;

CREATE TABLE User (
	username varchar(255),
	password varchar(255),
	isAdmin boolean, 
	salt text, 
	PRIMARY KEY(username)
);

CREATE TABLE DeletedUser(
	username varchar(255),
	password varchar(255),
	isAdmin boolean,
	salt text,
	PRIMARY KEY(username)
);

CREATE TABLE Friend(
	friend1 varchar(255),
	friend2 varchar(255),
	status boolean,
	time DATETIME,
	PRIMARY KEY(friend1, friend2)
); 

CREATE TABLE TookQuiz(
	quizID int, 
	username varchar(255), 
	score double,
	time DATETIME, 
	duration int, 
	practiceMode boolean, 
	rating double,
	PRIMARY KEY(quizID, username, time)
); 

CREATE TABLE Messages (
	fromUsername varchar(255),  
	toUsername varchar(255),
	type varchar(20),
	quizID int, 
	content text, 
	time DATETIME, 
	isRead boolean, 
	PRIMARY KEY(fromUserName, toUserName, time)
);

CREATE TABLE Announcements( 
	announcementsID int auto_increment, 
	username varchar(255),
	time DATETIME, 
	title text, 
	content text, 
	PRIMARY KEY(announcementsID)
); 

CREATE TABLE UserVisibleAnnouncements (
	username varchar(255), 
	announcementsID int
); 

CREATE TABLE Achievements (
	username varchar(255),
	type VARCHAR(50)
); 

CREATE TABLE Quiz (
	quizID int auto_increment, 
	username varchar(255),
	timeCreated DATETIME,
	name text, 
	description text, 
	randomOrder boolean, 
	multiplePages boolean, 
	immediateCorrection boolean, 
	practiceMode boolean,
	secondsPerQuestion int, -- 0 if not set
	PRIMARY KEY(quizID)
); 

CREATE TABLE Question (
       quizID int, 
       orderNumber int, 
       type varchar(25), 
       text text, 
       PRIMARY KEY(quizID, orderNumber)   
);

CREATE TABLE QuizTags (
	quizID int, 
	tag varchar(255), 
	PRIMARY KEY(quizID, tag)
);

CREATE TABLE QuizCategories (
	quizID int,
	category varchar(255),
	PRIMARY KEY(quizID, category)
);