--SQL queries to test the dashboard.jsp file

truncate table User; 
truncate table Friend; 
truncate table Announcements; 
truncate table Quiz; 
truncate table TookQuiz; 
truncate table Messages; 
truncate table UserVisibleAnnouncements;

insert into Announcements values(11, "kuda", '0000-00-00 03:00:00',
"important", "blah blah very important"); 
insert into Announcements values(13, "kuda", '0000-00-00 01:00:00',
"next important", "blah blah very important"); 
insert into Announcements values(15, "jujhaar", '0000-00-00 02:00:00',
"next important 2", "blah blah very important"); 

insert into UserVisibleAnnouncements values("rupa", 11);
insert into UserVisibleAnnouncements values("rupa", 13);
insert into UserVisibleAnnouncements values("ryan", 15);

insert into TookQuiz values(2, "jujhaar", 40, '2013-01-02 06:00:00', 70,
false);
insert into TookQuiz values(2, "ryan", 100, '2012-02-01 01:00:00', 70,
false);
insert into TookQuiz values(2, "mailyn", 40, '2011-03-30 02:00:00', 70,
false);
insert into TookQuiz values(4, "jujhaar", 40, '2010-04-05 03:00:00', 70,
false);
insert into TookQuiz values(4, "mailyn", 60, '2009-05-01 04:00:00', 70,
false);
insert into TookQuiz values(6, "jujhaar", 40, '2005-06-03 05:00:00', 70,
false);

insert into Quiz values(2, "m", '0000-00-00 02:00:00', "Quiz2", "awesome2",
false, false, false, false); 
insert into Quiz values(4, "m", '0000-00-00 03:00:00', "Quiz4", "awesome4",
false, false, false, false); 
insert into Quiz values(6, "m", '0000-00-00 02:00:00', "Quiz6", "awesome6",
false, false, false, false); 

insert into Messages values("ryan", "rupa", "note", -1, "hi hey",
'2008-06-03 05:00:00', false); 
insert into Messages values("mailyn", "rupa", "note", -1, "hi hey",
'2007-06-03 05:00:00', false); 
insert into Messages values("juj", "rupa", "note", -1, "hi hey",
'2006-06-03 05:00:00', false); 
insert into Messages values("kuda", "rupa", "note", -1, "hi hey",
'2005-06-03 05:00:00', false); 

insert into Friend values("ryan", "rupa", true, '2008-06-03 05:00:00'); 
insert into Friend values("kuda", "rupa", true, '2006-06-03 05:00:00'); 
insert into Friend values("rupa", "ryan", true, '2008-06-03 06:00:00');
insert into Friend values("rupa", "kuda", true, '2006-06-03 06:00:00');

insert into Messages values("ryan", "rupa", "challenge", 2, NULL,
'2008-06-03 04:00:00', false); 
insert into Messages values("mailyn", "rupa", "challenge", 4, NULL,
'2007-06-03 04:00:00', false); 
insert into Messages values("jujhaar", "rupa", "challenge", 6, NULL,
'2006-06-03 04:00:00', false); 
insert into Messages values("kuda", "rupa", "challenge", 2, NULL,
'2005-06-03 04:00:00', false);

insert into TookQuiz values(2, "rupa", 40, '2011-03-30 02:00:00', 70,
false);
insert into TookQuiz values(4, "rupa", 20, '2010-04-05 03:00:00', 70,
false);
insert into TookQuiz values(4, "rupa", 60, '2009-05-01 04:00:00', 70,
false);
insert into TookQuiz values(6, "rupa", 100, '2005-06-03 05:00:00', 70,
false);
insert into TookQuiz values(2, "ryan", 40, '2011-03-30 02:00:00', 70,
false);
insert into TookQuiz values(2, "ryan", 60, '2012-03-30 02:00:00', 70,
false);
insert into TookQuiz values(2, "kuda", 60, '2013-03-03 02:00:00', 70,
false);

insert into Achievements values("rupa", "Prolific Creator"); 
insert into Achievements values("rupa", "I am the Greatest"); 
insert into Achievements values("ryan", "Prolific Creator");
insert into Achievements values("ryan", "I am the Greatest");
insert into Achievements values("kuda", "I am the Greatest");