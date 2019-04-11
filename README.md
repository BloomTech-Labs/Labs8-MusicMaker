# MusicMaker

Music Master Maker is a hybrid full-stack web and iOS learning management app for music education. Teachers can use the web app to assign music sheet assignments, track and grade recorded sessions, and provide feedback to students. Students can use the iOS app to record their practices and receive feedback on their sessions.

Students signs up by using their portable Apple device to scan a QR code provided in the teacher's home screen.

The app is free for students and has a monthly fee for teachers.

## Table of Contents
1. [Visit the Website](#visit-the-website)
2. [Features List](#features-list)
3. [Local Setup](#local-setup)
4. [Endpoints](#endpoints)
5. [Meet the Team](#meet-the-team)


## Visit the Website
#### Teacher Web App 
* See the deployed FSW Front-end: https://www.musicmastermaker.com
   * Login into teacher Nadia Boulanger's account to see an account with sample students:
     * username: nadiab@gmail.com
     * password: 123456
* See the deployed Back-end: https://musicmaker-4b2e8.firebaseapp.com
* Tech Stack: React, Reactstrap, Styled-Components, Node, Express, Firebase Auth, Firebase Database
* Deployment: front-end via Netlify, back-end via Firebase Hosting

## Features List
#### Teacher Web App Features
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

## Local Setup
#### Teacher Local Web App
1. Clone repo.
2. Install environment and packages by typing `yarn install` within both the `/server/functions/` and `/client/` directories.
3. Type `yarn start` in each directory to spin up the servers.
4. Edit code as needed.

## Endpoints
#### Teachers Web App Endpoints
###### GET
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

## Meet the Team


|                                                [**Jeanette Fernandez**](https://github.com/jeanfern5)                                                |                                           [**Linh Bouniol**](https://github.com/linhbouniol)                                            |                                            [**Evan Carlstrom**](https://github.com/ecarlstrom)                                             |                                              [**Keiran Kozlowski**](https://github.com/keirankozlowski)                                               |                                            [**Vuk Rado**](https://github.com/vukrado)                                            |
| :--------------------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------: |
|                  [<img src="https://avatars2.githubusercontent.com/u/35198028?s=400&v=4" width="80">](https://github.com/jeanfern5)                  |             [<img src="https://avatars0.githubusercontent.com/u/41603901?s=400&v=4" width="80">](https://github.com/linhbouniol)             |            [<img src="https://avatars3.githubusercontent.com/u/4937141?s=400&v=4" width="80">](https://github.com/ecarlstrom)             |             [<img src="https://avatars2.githubusercontent.com/u/24276292?s=400&v=4" width="80">](https://github.com/keirankozlowski)             |          [<img src="https://avatars2.githubusercontent.com/u/33791641?s=400&v=4" width="80">](https://github.com/vukrado)           |
|                             [<img src="https://github.com/favicon.ico" width="15"> Github](https://github.com/jeanfern5)                             |                        [<img src="https://github.com/favicon.ico" width="15"> Github](https://github.com/linhbouniol)                        |                       [<img src="https://github.com/favicon.ico" width="15"> Github](https://github.com/ecarlstrom)                       |                        [<img src="https://github.com/favicon.ico" width="15"> Github](https://github.com/keirankozlowski)                        |                     [<img src="https://github.com/favicon.ico" width="15"> Github](https://github.com/vukrado)                      |
| [ <img src="https://static.licdn.com/sc/h/al2o9zrvru7aqj8e1x2rzsrca" width="15"> LinkedIn](https://www.linkedin.com/in/jeanettefernandez/) | [ <img src="https://static.licdn.com/sc/h/al2o9zrvru7aqj8e1x2rzsrca" width="15"> LinkedIn](https://www.linkedin.com/in/linh-bouniol-78599b180/) | [ <img src="https://static.licdn.com/sc/h/al2o9zrvru7aqj8e1x2rzsrca" width="15"> LinkedIn](https://www.linkedin.com) | [ <img src="https://static.licdn.com/sc/h/al2o9zrvru7aqj8e1x2rzsrca" width="15"> LinkedIn](https://www.linkedin.com/in/keirankozlowski/) | [ <img src="https://static.licdn.com/sc/h/al2o9zrvru7aqj8e1x2rzsrca" width="15"> LinkedIn](https://www.linkedin.com/in/vukrado//) |

