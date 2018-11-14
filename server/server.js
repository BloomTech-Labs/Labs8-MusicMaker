const admin = require('firebase-admin');
const express = require('express');

// Firebase-specific dependencies

const firebase = require('firebase');
const serviceAccount = require('./musicmaker-4b2e8-firebase-adminsdk-v1pkr-34d1984175.json');
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
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://musicmaker-4b2e8.firebaseio.com"
});
const db = admin.firestore();
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

// GET a list of all assignments for a specific student
// I can make this into a teachers -> students type endpoint, but it seems unnecessary for now

app.get('/students/:id/assignments', async (req, res, next) => {
  try {
    const id = req.params.id;
    // if(!id) throw new Error('Please provide a student ID.');
    const assignmentsRef = await db.collection('students').doc(id).collection('assignments').get();
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

// add individual teacher with just an ID

// app.post('/teachers', async (req, res, next) => {
//   try {
//     const firstName = req.body.firstName;
//     const lastName = req.body.lastName;
//     const data = { firstName, lastName };
//     const ref = await db.collection('teachers').doc(id).collection('settings').doc(id);
//     res.json({
//       id: ref.id,
//       data
//     });
//   } catch(err) {
//     next(err);
//   }
// });

// app.post('/teachers', async (req, res, next) => {
//   (res => {
//     const obj = res;
//     const teacherData = {
//       firstName: obj.firstName,
//       lastName: obj.lastName
//     };
//     return db.collection('teachers').doc(id).collection('settings').doc(id)
//       .update(teacherData).then(() => {
//         console.log('New teacher added to database!');
//         res.json(teacherData);
//       })
//   });
// });

app.post('/teachers', (req, res) => {
  let data = {
    QRCode: req.QRCode,
    email: req.email
  };

  let setTeacher = db.collection('teachers').set(data);
  res.json(data);
})

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
