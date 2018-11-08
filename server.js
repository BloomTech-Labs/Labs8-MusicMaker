const admin = require('firebase-admin');
const express = require('express');

// Firebase-specific dependencies

const firebase = require('firebase');
const config = {
    apiKey: "AIzaSyCls0XUsqzG0RneHcQfwtmfvoOqHWojHVM",
    authDomain: "musicmaker-4b2e8.firebaseapp.com",
    databaseURL: "https://musicmaker-4b2e8.firebaseio.com",
    projectId: "musicmaker-4b2e8",
    storageBucket: "musicmaker-4b2e8.appspot.com",
    messagingSenderId: "849993185408"
};
const Firestore = require('@google-cloud/firestore');
const firestore = new Firestore({
  projectId: "musicmaker-4b2e8",
});
firebase.initializeApp(config);
const db = firebase.firestore();
const settings = {timestampsInSnapshots: true};
firestore.settings(settings);
///////////////////////

const app = express();
// test GET request, adding key/value pair to Firebase

app.get('/teachers', async (req, res, next) => {
  try {
    const teachersRef = await db.collection('teachers').get();
    const teachers = [];
    teachersRef.forEach((doc) => {
      teachers.push({
        id: doc.id,
        data: doc.data
      });
    });
    res.json(teachers);
  } catch(err) {
    next(err);
  }
});

// GET a list of all students studying under a specific teacher

app.get('/teachers/:id', async (req, res, next) => {
  try {
    const id = req.params.id;
    // if(!id) throw new Error('Please provide a teacher ID.');
    const studentsRef = await db.collection('teachers').doc(id).collection('students').get();
    const students = [];
    studentsRef.forEach((doc) => {
      students.push({
        id: doc.id,
        data: doc.data
      });
    });
    res.json(students);
  } catch (err) {
    next (err);
  }
});


// GET a list of all assignments listed under a specific teacher
// can consider changing this to a more high-level 'assignments' endpoint

app.get('/teachers/:id/assignments', async (req, res, next) => {
  try {
    const id = req.params.id;
    // if(!id) throw new Error('Please provide a teacher ID.');
    const assignmentsRef = await db.collection('teachers').doc(id).collection('assignments').get();
    const assignments = [];
    assignmentsRef.forEach((doc) => {
      assignments.push({
        id: doc.id,
        data: doc.data
      });
    });
    res.json(assignments);
  } catch(err) {
    next(err);
  }
});

// POST

app.post('/teachers', async (req, res, next) => {
  try {
    const { email }  = req.body.email;
    // if(!name) throw new Error('Name is blank!');
    const teacherData = { email };
    const teachersRef = await db.collection('teachers').document('').add(teacherData);
    res.json({
      id: teachersRef.id,
      teacherData
    });
  } catch(err) {
    console.log(err.message);
    next(err);
  }
});

///////////////////////

// PUT

// app.put('/', (req, res) => {
//   console.log('PUT test');
//   res.send('hello!');
// });

///////////////////////

// DELETE

// app.delete('/', (req, res) => {
//   console.log('DELETE test');
//   res.send('hello!');
// });

///////////////////////

// server instantiation

const server = app.listen(8000, function () {

  const host = server.address().address;
  const port = server.address().port;

  console.log(`Server listening on port ${port}.`);
});
