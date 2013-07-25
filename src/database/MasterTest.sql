truncate table User; 
truncate table Friend; 
truncate table Announcements; 
truncate table Quiz; 
truncate table TookQuiz; 
truncate table Messages; 
truncate table UserVisibleAnnouncements;
truncate table Question;
truncate table QuizTags;
truncate table QuizCategories;

-- the password for each user is simply the first character of their username
insert into User values 
	('ryan', 'dbd438e953ca5dbecf27b3da9fea462f4c7b0d63', 1, '1ec1c11e503762b8'),
	('jujhaar', 'eacb3d95ba4922401a6f48af93093899a34a238b', 0, '76eac27fe8c0cd70'),
	('kuda', 'c36f1042004d4c1f452ddb3bc9c20c5177be7eb3', 0, '179283c2532eb2ac'),
	('rupa', '7a879faf9177fa534440c3b94fe8b0dc9a5f73d6', 0, '8f221068ea923914'),
	('mailyn', 'b3e4ad50787615b6c0d151c80c2309ecc3e0fe49', 0, '9278e07a2ba69cd3');


INSERT INTO Quiz VALUES 
	(1,'ryan','2013-02-28 16:26:21','Quiz with Questionzzzz!','This one has a response question! And an Image question! so cool!',1,1,1,0, 0),
	(3,'jujhaar','2013-02-28 16:52:54','Quiz with Questionz!','This one has a response question! And an Image question! so cool!',1,1,0,1, 0),
	(5,'kuda','2013-02-28 17:05:31','CS Classes @ Stanford','Quiz about CS classes at Stanford.',0,1,1,1, 30),
	(11,'mailyn','2013-03-02 00:05:30','The Stanford Quiz','The best quiz about Stanford.',0,1,0,1, 0),
	(13,'ryan','2013-03-02 01:00:00','Cool Quiz','Cool',0,0,0,1, 0),
	(15,'jujhaar','2013-03-02 17:00:00','Another Quiz','Another',0,0,0,1, 0),
	(17,'ryan','2013-03-02 05:00:01','Fantastic Quiz','Fantastic',0,0,0,1,0),
	(21,'jujhaar','2013-03-02 21:00:00','Best Quiz','Best',0,0,0,1,0),
	(23,'ryan','2013-03-08 20:10:00','Hall Dinner','Hall dinner quiz!',0,1,0,1,0),
	(31,'ryan','2013-03-13 15:07:33', 'Test XML Escaping', 'Testing, testing, 1 2 3. ',1,0,0,0,0);


INSERT INTO Question VALUES
	(1,1,'question-response','<question type=\"question-response\"><query>What is the quizID?</query><answer-list><answer>More than 1</answer><answer>Not 1</answer><answer>Please not 1</answer></answer-list></question>'),
	(1,2,'picture-response','<question type=\"picture-response\"><image-location>https://lh3.googleusercontent.com/-IT2yFdNVDK8/TrhNrYrH4jI/AAAAAAAAASM/tSO9I_MXceQ/s482/SU_BlockStree_2colorjpg300px.jpg</image-location><answer-list><answer>Stanford</answer><answer>Estanford</answer><answer>Cal Sucks</answer></answer-list></question>'),
	(3,1,'picture-response','<question type=\"picture-response\"><image-location>https://lh3.googleusercontent.com/-IT2yFdNVDK8/TrhNrYrH4jI/AAAAAAAAASM/tSO9I_MXceQ/s482/SU_BlockStree_2colorjpg300px.jpg</image-location><answer-list><answer>Stanford</answer></answer-list></question>'),
	(3,2,'question-response','<question type=\"question-response\"><query>Who was the first President?</query><answer-list><answer>Washington</answer><answer>George Washington</answer></answer-list></question>'),
	(5,1,'picture-response','<question type=\"picture-response\"><image-location>http://www-cs-faculty.stanford.edu/~eroberts/images/EricInClass.gif</image-location><answer-list><answer>Eric</answer><answer>Eric Roberts</answer></answer-list></question>'),
	(5,2,'question-response','<question type=\"question-response\"><query>Which is the best class?</query><answer-list><answer>CS 108</answer><answer>CS108</answer></answer-list></question>'),
	(5,3,'question-response','<question type=\"question-response\"><query>Which is the first course?</query><answer-list><answer>CS 106A</answer><answer>CS 106</answer><answer>CS106A</answer></answer-list></question>'),
	(5,4,'picture-response','<question type=\"picture-response\"><image-location>http://www.stanford.edu/class/cs106a/karel.png</image-location><answer-list><answer>Karel</answer></answer-list></question>'),
	(11,1,'picture-response','<question type=\"picture-response\"><image-location>http://image.com/image.png</image-location><answer-list><answer>Image</answer><answer>Cool Image</answer></answer-list></question>'),
	(11,2,'question-response','<question type=\"question-response\"><query>Which is the best group?</query><answer-list><answer>Team Awesome!</answer></answer-list></question>'),
	(11,3,'picture-response','<question type=\"picture-response\"><image-location>iamag2</image-location><answer-list><answer>sdf</answer></answer-list></question>'),
	(11,4,'picture-response','<question type=\"picture-response\"><image-location>jsdfklhjsd</image-location><answer-list><answer>sdsdf</answer></answer-list></question>'),
	(13,1,'picture-response','<question type=\"picture-response\"><image-location></image-location><answer-list><answer></answer><answer></answer></answer-list></question>'),
	(15,2,'picture-response','<question type=\"picture-response\"><image-location>http://www.stanford.edu/~psyoung/psyoung.jpg</image-location><answer-list><answer>Patrick</answer><answer>p-dawg</answer></answer-list></question>'),
	(15,3,'question-response','<question type=\"question-response\"><query>Why?</query><answer-list><answer>Because</answer></answer-list></question>'),
	(17,1,'picture-response','<question type=\"picture-response\"><image-location>http://www.stanford.edu/~psyoung/psyoung.jpg</image-location><answer-list><answer>Patrick</answer><answer>Patrick Young</answer><answer>pdawg</answer><answer>p-dawg</answer></answer-list></question>'),
	(21,1,'multiple-choice','<question type=\"multiple-choice\"><query>Who let pdawg out?</query><option answer=\"answer\">Jujhaar</option><option>Rupa</option><option>Ryan</option><option>Mailyn</option></question>'),
	(21,2,'picture-response','<question type=\"picture-response\"><image-location>http://www.stanford.edu/~psyoung/psyoung.jpg</image-location><answer-list><answer>Patrick</answer><answer>Patrick Young</answer><answer>pdawg</answer></answer-list></question>'),
	(23,1,'fill-in-blank','<question type=\"fill-in-blank\"><pre>For hall dinner, we are going to</pre><blank></blank><post>to eat yummy food.</post><answer-list><answer>The Counter</answer></answer-list></question>'),
	(31,1,'multiple-choice','<question type="multiple-choice"><query>5 &gt; 4</query><option answer="answer">True</option><option>False</option></question>'),
	(31,2,'multiple-choice','<question type="multiple-choice"><query>5 &lt; 4</query><option answer="answer">False</option><option>True</option></question>'),
	(31,3,'question-response','<question type="question-response"><query>Where did Sam &amp; Frodo go?</query><answer-list><answer>Mordor</answer></answer-list></question>'),
	(31,4,'picture-response','<question type="picture-response"><image-location>http://9to5mac.files.wordpress.com/2012/09/apple-iphone-5-announcement-analysis.jpeg?w=591&amp;h=600</image-location><answer-list><answer>iPhone</answer><answer>iphone</answer></answer-list></question>'),
	(31,5,'fill-in-blank','<question type="fill-in-blank"><pre>I want a PB</pre><blank></blank><post>J sandwich.</post><answer-list><answer>&amp;</answer><answer>and</answer></answer-list></question>');

insert into Announcements values(11, "kuda", '0000-00-00 03:00:00',
"important", "blah blah very important"); 
insert into Announcements values(13, "kuda", '0000-00-00 01:00:00',
"next important", "blah blah very important"); 
insert into Announcements values(15, "jujhaar", '0000-00-00 02:00:00',
"next important 2", "blah blah very important"); 

insert into UserVisibleAnnouncements values("rupa", 11);
insert into UserVisibleAnnouncements values("rupa", 13);
insert into UserVisibleAnnouncements values("ryan", 15);

insert into TookQuiz values(1, "jujhaar", 40, '2013-01-02 06:00:00', 70,
false, 3);
insert into TookQuiz values(1, "ryan", 100, '2012-02-01 01:00:00', 70,
false, 3);
insert into TookQuiz values(1, "mailyn", 40, '2011-03-30 02:00:00', 70,
false, 3);
insert into TookQuiz values(3, "jujhaar", 40, '2010-04-05 03:00:00', 70,
false, 3);
insert into TookQuiz values(3, "mailyn", 60, '2009-05-01 04:00:00', 70,
false, 3);
insert into TookQuiz values(5, "jujhaar", 40, '2005-06-03 05:00:00', 70,
false, 3);

insert into Messages values("ryan", "rupa", "note", -1, "hi hey",
'2008-06-03 05:00:00', false); 
insert into Messages values("mailyn", "rupa", "note", -1, "hi hey",
'2007-06-03 05:00:00', false); 
insert into Messages values("juj", "rupa", "note", -1, "hi hey",
'2006-06-03 05:00:00', false); 
insert into Messages values("kuda", "rupa", "note", -1, "hi hey",
'2005-06-03 05:00:00', false); 

insert into Friend values("ryan", "rupa", false, '2008-06-03 05:00:00'); 
insert into Friend values("mailyn", "rupa", false, '2007-06-03 05:00:00'); 
insert into Friend values("kuda", "rupa", false, '2006-06-03 05:00:00'); 
insert into Friend values("jujhaar", "rupa", false, '2005-06-03 05:00:00');
insert into Friend values("ryan", "jujhaar", true, '1999-12-31 23:59:59');
insert into Friend values("jujhaar", "ryan", true, '1999-12-31 23:59:59');

insert into Messages values("ryan", "rupa", "challenge", 1, NULL,
'2008-06-03 04:00:00', false); 
insert into Messages values("mailyn", "rupa", "challenge", 3, NULL,
'2007-06-03 04:00:00', false); 
insert into Messages values("jujhaar", "rupa", "challenge", 5, NULL,
'2006-06-03 04:00:00', false); 
insert into Messages values("kuda", "rupa", "challenge", 11, NULL,
'2005-06-03 04:00:00', false);

insert into TookQuiz values(1, "rupa", 40, '2011-03-30 02:00:00', 70,
false, 3);
insert into TookQuiz values(3, "rupa", 20, '2010-04-05 03:00:00', 70,
false, 3);
insert into TookQuiz values(3, "rupa", 60, '2009-05-01 04:00:00', 70,
false, 3);
insert into TookQuiz values(5, "rupa", 100, '2005-06-03 05:00:00', 70,
false, 3);

insert into Achievements values("rupa", "Prolific Author"); 
insert into Achievements values("rupa", "I am the greatest"); 

insert into Achievements values("mailyn", "Amateur Author");
insert into Achievements values("mailyn", "Prolific Author");
insert into Achievements values("mailyn", "Prodigious Author");
insert into Achievements values("mailyn", "Quiz Machine");
insert into Achievements values("mailyn", "I am the greatest");
insert into Achievements values("mailyn", "Practice Makes Perfect");

insert into QuizTags values(13, "cool");
insert into QuizTags values(21, "best");
insert into QuizTags values(17, "fantastic");
insert into QuizTags values(15, "fantastic");

insert into QuizCategories values(13, "made by ryan");
insert into QuizCategories values(15, "made by jujhaar");
insert into QuizCategories values(17, "made by ryan");
