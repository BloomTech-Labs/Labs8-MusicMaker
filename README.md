# MusicMaker

Music Master Maker is a hybrid app for both web and iOS that allows music teachers to assign pieces for their students to practice, and for students to use their phones to record their practice sessions and submit them back to the teacher for feedback.

The app has push notifications and emails students when an assignment has been given and to teachers when one has been submitted.

Students sign up by using their iPhone to scan a QR code provided by the teacher.

The app is free for students and has a monthly fee for teachers.

## Table of Contents
1. [Live_Versions](#live_versions)
2. [Feature_List](#feature_list)
3. [Local_Setup](#local_setup)
4. [Endpoints](#endpoints)

## Live Versions
1. See the deployed FSW Front-end: https://musicmaker-teacher.netlify.com
* Tech used: React, Redux, Reactstrap
2. See the deployed Back-end: https://musicmaker-4b2e8.firebaseapp.com/test
* Tech used: Node, Express, Firebase
3. See the deployed DB: https://musicmaker-4b2e8.firebaseio.com/
* Tech used: Firebase, Firestore

## Feature List
#### Teachers
1. Sign up - can use email/password or Google OAuth.
2. Sign in - can use email/password or Google OAuth.
3. Reset Password - sends an email to the attached email address to reset.
4. Sign out - remove auth token to sign out.
5. Student View - shows all students as individual cards; clicking an individual card will bring up the individual student's information and any assignments they have been assigned.
6. Create Assignment View - create a new assignment template with a few text fields and a PDF for sheet music.
7. Assignment View - shows all assignment templates as individual cards; clicking an individual card will bring up the individual assignment attributes and any students that have been assigned to it and to assign additional students to it.
8. Grading View - shows all assignments submitted by students for grading as individual cards; clicking an individual card will bring up the assignment information and allow feedback to be recorded.
9. Billing View - allow payment through the Stripe API. This will enable other pages which have been route-protected.
10. Settings View - see and edit user account info.

#### Students

## Local setup
1. Clone repo.
2. Install environment and packages by typing `yarn install` within both the `/server/functions/` and `/client/` directories.
3. Type `yarn start` in each directory to spin up the servers.
4. Edit code as needed.

## Endpoints
#### Teachers
###### GET
1. /test: 
* test endpoint to check that server is up.
1. /teacher/:idTeacher/students
* retrieves a teacher's list of students.
* fetches student name, instrument, proficiency level, and email.
2. /teacher/:idTeacher/student/:idStudent
* retrieves an individual student assigned to the teacher
* fetches student name, instrument, proficiency level, and email.
3. /teacher/:idTeacher/student/:idStudent/assignments
* fetches list of assignments the student has been assigned.
4. /teacher/:idTeacher/assignment/:idAssignment/students
* fetches list of students assigned to the assignment
5. /teacher/:idTeacher/assignment/:idAssignment/student/:idStudent
* fetches a completed or uncompleted assignment from a student
6. /teacher/:idTeacher/assignments
* fetches a list of all ungraded assignments for a teacher
7. /teacher/:idTeacher/assignment/:idAssignment
* fetches an individual ungraded assignment
8. /teacher/:idTeacher/settings
* retrieves a teacher's account settings
* fetches email, name (first, last, prefix), and QR code

###### POST
1. /teacher/:idTeacher/assignment/:idAssignment/assignToStudent
* posts an assignment from a teacher to a student, which allows the student access to complete it.
2. /teacher/:idTeacher/createAssignment
* posts a new assignment template to a teacher's list of assignments. This assignment can then be assigned to student(s)
3. /uploadPDF
* uploads a PDF to the Firestore database
* should be used in conjunction with the create assignment endpoint.
4. /addNewTeacher
* adds a teacher's initial settings including name, email, and generates a QR code
5. /teacher/:idTeacher/charge
* uses the Stripe API to post a payment to a specific teacher account
* a paid account allows full access to all features

###### PUT
1. /teacher/:idTeacher/assignment/:idAssignment/student/:idStudent
* edits an assignment when a teacher grades it. 
* should post feedback and grade
2. /teacher/:idTeacher/settingsEdit
* edits teacher account settings

###### DELETE
1. /teacher/:idTeacher/assignment/:idAssignment
* deletes an assignment template

#### Students
