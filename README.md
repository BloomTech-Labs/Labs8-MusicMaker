# MusicMaker

Music Master Maker is a hybrid app for both web and iOS that allows music teachers to assign pieces for their students to practice, and for students to use their phones to record their practice sessions and submit them back to the teacher for feedback.

The app has push notifications and emails students when an assignment has been given and to teachers when one has been submitted.

Students sign up by using their iPhone to scan a QR code provided by the teacher.

The app is free for students and has a monthly fee for teachers.

## Table of Contents
1. [Live Version](#live_version)
3. [Instructions](#instructions)
4. [API Reference](#api_reference)

## Live Version
See the live version here:
<link>https://musicmaker-teacher.netlify.com/</link>

## Instructions


## API Reference
Teacher Requests:
GET
  - Get QR code on signup
  - Get list of all students
  - Get individual student details
  - Get list of all assignments
  - Get individual assignment details
  - Get Stripe token for payment
POST
  - Create a teacher account
  - Create an assignment
  - Upload a PDF
  - Submit feedback for an assignment
  - Make a payment to Stripe
PUT
  - Update teacher account info
DELETE
  - Delete an assignment

Student Requests:
GET
  - Get teacher QR code when scanning one
  - Get a list of all assignments
  - Get individual assignment details
  - Get the attached PDF
POST
  - Assign a student to a teacher account based on QR code
  - Post a video
PUT
  - Update student account info
  - Update QR code link for a new teacher
DELETE
  - None yet
