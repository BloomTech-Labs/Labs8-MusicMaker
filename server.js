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

// committing with GET request for now
// additional comment to resubmit PR

// POST

app.post('/teachers', async (req, res, next) => {
  try {
    const { email }  = req.body.settings;
    // if(!name) throw new Error('Name is blank!');
    const teacherData = { email };
    const teachersRef = await db.collection('documents/teachers').add(teacherData);
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

//=================================================== STUDENTS =================================================================

//GET all of student aassignments
app.get('/student/:idStudent', async (req, res, next) => {
    try {
    const studentId = req.params['idStudent'];

    const assignmentsRef = await db.collection('students').doc(studentId).collection('assignments').get();
    const assignments = [];
    assignmentsRef.forEach((snap) => {
        assignments.push({
        id: snap.id,
        data: snap.data
        });
    });
    res.json(assignments);
    } catch(err) {
    next(err);
    }
});

//GET a single assignment from a student
app.get('/student/:idStudent/assigment/:idAssignment', async (req, res, next) => {
    try {
        const studentId = req.params['idStudent'];
        const assignmentId = req.params['idAssignment'];
    
        const stringList = ["assignmentName", "feedback","instructions", "instrument", "level", "piece","sheetMusic","status","teacher", "video"];
        const assigmentRef =  await db.collection('students').doc(studentId).collection('assignments').doc(assignmentId).get()
    
        jsonRes = {};
        for (let i =0; i < stringList.length; i++){
            let value = assigmentRef.get(stringList[i]);
            if(!("object" == typeof(value))){
                jsonRes[stringList[i]] = value;
            }else{
                console.log("Error: Should not have object in this list")
            }
        }
        let dueDate = assigmentRef.get("dueDate");
        jsonRes["dueDate"] = dueDate;
    
        
        // let musicSheet = assigmentRef.get("sheetMusic");
        // let segments = musicSheet['0']._key.path.segments
        // let dir_name = segments[segments.length -2];
        // let filename = segments[segments.length -1];
        // //console.log(musicSheet['0']._key.path.segments);
    
        // var gsReference = storage.refFromURL('gs://musicmaker-4b2e8.appspot.com/' + dir_name + '/' + filename);
    
        // //gs://musicmaker-4b2e8.appspot.com
        // gs://musicmaker-4b2e8.appspot.com
        
        res.json(jsonRes);
    } catch (err) {
    next (err);
    }
    });

// server instantiation

const server = app.listen(8000, function () {

  const host = server.address().address;
  const port = server.address().port;

  console.log(`Server listening on port ${port}.`);
});
