# MusicMaker

Music Master Maker is a hybrid app for both web and iOS that allows music teachers to assign pieces for their students to practice, and for students to use their phones to record their practice sessions and submit them back to the teacher for feedback.

The app has push notifications and emails students when an assignment has been given and to teachers when one has been submitted.

Students sign up by using their iPhone to scan a QR code provided by the teacher.

The app is free for students and has a monthly fee for teachers.

## Table of Contents
1. [Live Versions](#live_versions)
2. [Feature List](#feature_list)
3. [Local Setup](#local_setup)

## Live Versions
1. See the deployed FSW Front-end: https://musicmaker-teacher.netlify.com
2. See the deployed Back-end: https://musicmaker-4b2e8.firebaseapp.com/test
3. See the deployed DB: https://musicmaker-4b2e8.firebaseio.com/

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

