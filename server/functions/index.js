const functions = require('firebase-functions');
const firebase = require('firebase-admin');
const express = require('express');
const cors = require('cors');

firebase.initializeApp({
    apiKey: "AIzaSyCls0XUsqzG0RneHcQfwtmfvoOqHWojHVM",
    authDomain: "musicmaker-4b2e8.firebaseapp.com",
    databaseURL: "https://musicmaker-4b2e8.firebaseio.com",
    projectId: "musicmaker-4b2e8",
    storageBucket: "musicmaker-4b2e8.appspot.com",
    messagingSenderId: "849993185408"
});

const Firestore = require('@google-cloud/firestore');
const firestore = new Firestore({projectId: "musicmaker-4b2e8"});
const settings = {timestampsInSnapshots: true};
firestore.settings(settings);

const db = firebase.firestore();
const app = express();
app.use(express.json());
app.use(cors());

//===============================================================================================================================================

// TEST for sanity checks
app.get('/test', (req, res) => {
    res.status(200).send({MESSAGE: 'HELLO FROM THE BACKEND! :)'});
});



//GET should retrieve teachers settings info.: email and name
app.get('/teacher/:idTeacher/settings', async (req, res, next) => {
  try{
    const teacherId = req.params['idTeacher'];
    const settings = {};

    const settingsRef = await db.collection('teachers').doc(teacherId);
    const getSettings = await settingsRef.get()
    .then(doc => {
      global = doc.data();
      settings[doc.id] = [global.email, global.name.firstName, global.name.lastName]
    })
    res.status(200).json(settings);

  } catch (err){
    next (err);
  }
});

//GET should retrieve teacher's all ungraded assignments
//details: assignmentName, instructions, instrument, level, piece
app.get('/teacher/:idTeacher/assignments', async (req, res, next) => {
  try{
      const teacherId = req.params['idTeacher'];
      const assignments = {};  

      const assignmentRef =  await db.collection('teachers').doc(teacherId).collection('assignments');
      const allAssignments = await assignmentRef.get()
      .then(snap => {
        snap.forEach(doc => {
          global = doc.data();
          assignments[doc.id] = [global.assignmentName, global.instructions, global.instrument, global.level, global.piece]          
        })
      });
      res.json(assignments);

  } catch (err){
    next (err);
  }
});



app.listen(8000, function () {
    console.log(`========================= RUNNING ON PORT 8000 =========================`);
});

exports.app = functions.https.onRequest(app);
  
