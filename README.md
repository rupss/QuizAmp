QuizAmp
=======

Final project for CS108 (Object Oriented Systems Design). 
Teammates: Lennon Chimbumu, Mailyn Fidler, Ryan Globus, Jujhaar Singh

Assignment handout: www.stanford.edu/class/cs108/handouts122/34QuizWebsite.pdf‎

SPECIAL INSTRUCTIONS:
Please load project in Chrome. Although we used jQuery and cross-compatible HTML/CSS, we have only tested in Chrome.

NOTES:
On the Quiz Results page, do not refresh or click the back button, as it will resubmit your quiz results. 
The first admin must be added manually in the database (and then they can add admins). 
On a timed quiz, if the timer runs out on the last question, the form will automatically submit. 
If the user tries to submit at the same time, this could result in double submission (which shouldn’t be recorded in the database since one user can only take a quiz once per second).
On lists of top scorers, our queries list ties by looking at duration.  For design purposes, not everywhere top scorers are listed do we list duration, so it may not be immediately apparent.
On the dashboard, “Popular Quizzes” are determined by the number of times that they have been taken. 
Tags cannot include any special characters.

EXTENSIONS:

Account Reactivation: If an admin deletes an account, the user information is simply moved to the DeletedUser table. All their information is still present, but they can’t log in. An admin can reactivate their account, which simply moves them back to the User table.

Achievements: we added images for each achievement type as well as tooltips explaining how each achievement was earned.  This does not apply to the “friend activity” fields.

Admin Page: the admin page, in addition to what was required, allows the admin to view all announcements he authored and all announcements created by anyone. We also expanded site statistics to include displaying the top quiz takers, the top scorers ever, and the top creators ever.

Assignment Name: “Quizzler” is our suggestion.

Categories: After a quiz has been created, the quiz creator and the admins can set the quiz’s category from the Quiz Summary page. A quiz can only have one category. If someone sets the category when the quiz already has a category, then the most recent categorization is used. One can view quizzes by category from the selectQuiz page. 

Challenges Auto-Updating: When one user challenges another user to take a quiz, the challenge is deleted after the “challengee” takes that quiz. 

Dashboard Page:  we added a section that displays a random question from a random quiz.

Dismissing Announcements: Users can dismiss announcements by clicking on a red ‘X’ next to the announcement on the dashboard or on the view all announcements pages. Users no longer see announcements they dismissed.

Non-Registered Access: Non-registered users have “guest” access and are able to browse quizzes, view quiz summary pages, tag quizzes, search quizzes by tag, and view quizzes by category. If the guest user tries to access any other page, it redirects to the login page. 

Notes: We distinguish between read and unread notes on the dashboard and the view all notes pages. Notes become read when the recipient visits the Individual Message page for that note (i.e by clicking on the note text). On the dashboard, unread notes are a darker grey while read notes are a lighter grey, and on the view all notes page, unread notes are grey while read notes are white. 

Multi-Answer Questions: One question type (Multiple Answer Question) works as explained in the handout. These questions make quiz takers answer a certain number of answers. Answers cannot be synonymous (so there is a set list of answers). Answers may or may not need to be in order, as determined by the quiz creator. Multiple answers cannot be the same.

Quiz Results: the quiz results page, in addition to what was required, displays the user’s top five most recent scores, the top five scorers overall, and allows the user to select a friend and view that friends five most recent scores.

Practice Mode: Our practice mode extension lets a user take a quiz without it counting as a score and without timing.  After a user gets a question right three times in the same session, the question is replaced by a message that the user has mastered the question.  If all questions are answered correctly three times, the user is redirected to the quiz summary page.  The user can also exit practice mode at any time.

Rating: We implemented a numeric rating system where the user enters their rating of a particular quiz. The rating interface is shown just after a user finishes a particular quiz. The user can choose to leave the field blank or they can input a rating between 0 and 5. The Rating for a particular quiz is shown on the quiz summary page. If a quiz has not been rated, it will display a rating of 0.

Salt: The password salt is generated using a SHA1 generated array of 64bits. The password and salt are then encrypted and returned to any the calling function. We use java.security.SecureRandom to create the array of random bits that will be used to calculate the salt. 

Tags: After a quiz has been created, anyone can tag the quiz. One can search for quizzes by tag from the selectQuiz page. 

Timed Questions: If a quiz is one page per question, the creator can set a time limit for each question. When taking these timed quizzes, a timer counts down at the top. When moving to the next question, the timer resets to the default time, and users cannot go back. When the timer goes to 0, the page forces the user to the next question, or to submit the quiz if on the last question.

XML Downloading/Upload: On the Quiz Summary page, the quiz creator and admins only can view an XML representation of the Quiz. From this they can download it manually. Then, on the quiz creation page, there is a link to let users upload an XML representation of a quiz rather than using the quiz-creation GUI. The XML uploading page provides the DTD to be used.

