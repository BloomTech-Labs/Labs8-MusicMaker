// // const https = require('https');
// var admin = require("firebase-admin");
// var functions = require('firebase-functions');
//  // const serviceAccount = require("./private_key.json");
//  //  admin.initializeApp({
// //      credential: admin.credential.cert(serviceAccount),
// //      databaseURL: 'https://musicmaker-4b2e8.firebaseio.com'
// //    });
//  // var db = admin.firestore();
// // var students = db.collection('students').doc('NKMNNypkVXUj4BSSyTPb').collection('assignments').doc('jKqbaQTm5lQikF6MMD9K').sheetMusic
// // //db.ref().set({'name' : 'test'});
//  // console.log("THIS", students);
//  var serviceAccount = require("./private_key.json");
//  admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
// });
//  var db = admin.firestore();
// // collection = db.collection('students').get().then(function(student) {
// //     student.forEach(function(doc){
// //         console.log(doc.data())
        
// //     })
// // });
//  collection = db.collection('students').doc("NKMNNypkVXUj4BSSyTPb").collection('assignments').get().then(function(student) {
//     student.forEach(function(doc){
//         console.log(doc.data)
//     })
// });
//  var field_list = ["dueDate", "feedback","instructions", "instrument", "level", "piece","sheetMusic","status","teacher", "video"];
// collection = db.collection('students').doc("NKMNNypkVXUj4BSSyTPb").collection('assignments').doc('jKqbaQTm5lQikF6MMD9K').get()
//     .then(function(res) {
//         field_list.forEach(function(field){
//             console.log([field, ":", res.get(field)].join(' '))
//          })
// })
//  // let baseUrl = 'https://firestore.googleapis.com/v1beta1/'
// // https.get(firebaseEndpoint, (resp) => {
// //     let data = '';
    
// //     resp.on('data', (chunk) => {
// //         data += chunk;
// //     });
//  //     resp.on('end', () => {
// //         console.log(JSON.parse(data).explanation);
// //     });
// // }).on('error', (error) => {
// //     console.log('ERROR:' + err.message);
// // });
//  // const port = 8000;
//  // exports.studentAssignments = functions.https.onRequest(req, res) => {
// //     res.status(200).send()
// // }
//  // app.listen(port, () => {
// //     console.log(`\n===== RUNNING ON PORT ${port} =====\n`);
// // });
//  // const express = require('express');
//  // const app = express();
// // const port = 8000;
//  // app.use(express.json());
//  // // Endpoints
// // app.get('/', (req, res) => {
// //     res.send('hello world');
// // });
//  // app.get('/student/assignments', (req, res) => {
// //     db('assignments')
// //         .then(assignments => {
// //             res.status(200).json(assignments)
// //         })
// //         .catch(err => {
// //             res.status(500).json(err);
// //         })
// // });
// const https = require('https');
// var admin = require("firebase-admin");
// var functions = require('firebase-functions');
//  // const serviceAccount = require("./private_key.json");
//  //  admin.initializeApp({
// //      credential: admin.credential.cert(serviceAccount),
// //      databaseURL: 'https://musicmaker-4b2e8.firebaseio.com'
// //    });
//  // var db = admin.firestore();
// // var students = db.collection('students').doc('NKMNNypkVXUj4BSSyTPb').collection('assignments').doc('jKqbaQTm5lQikF6MMD9K').sheetMusic
// // //db.ref().set({'name' : 'test'});
//  // console.log("THIS", students);
//  var serviceAccount = require("./private_key.json");
//  admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
// });
//  var db = admin.firestore();
// // collection = db.collection('students').get().then(function(student) {
// //     student.forEach(function(doc){
// //         console.log(doc.data())
        
// //     })
// // });
//  collection = db.collection('students').doc("NKMNNypkVXUj4BSSyTPb").collection('assignments').get().then(function(student) {
//     student.forEach(function(doc){
//         console.log(doc.data)
//     })
// });
//  var field_list = ["dueDate", "feedback","instructions", "instrument", "level", "piece","sheetMusic","status","teacher", "video"];
// collection = db.collection('students').doc("NKMNNypkVXUj4BSSyTPb").collection('assignments').doc('jKqbaQTm5lQikF6MMD9K').get()
//     .then(function(res) {
//         field_list.forEach(function(field){
//             console.log([field, ":", res.get(field)].join(' '))
//          })
// })
//  // let baseUrl = 'https://firestore.googleapis.com/v1beta1/'
// // https.get(firebaseEndpoint, (resp) => {
// //     let data = '';
    
// //     resp.on('data', (chunk) => {
// //         data += chunk;
// //     });
//  //     resp.on('end', () => {
// //         console.log(JSON.parse(data).explanation);
// //     });
// // }).on('error', (error) => {
// //     console.log('ERROR:' + err.message);
// // });
//  // const port = 8000;
//  // exports.studentAssignments = functions.https.onRequest(req, res) => {
// //     res.status(200).send()
// // }
//  // app.listen(port, () => {
// //     console.log(`\n===== RUNNING ON PORT ${port} =====\n`);
// // });
//  // const express = require('express');
//  // const app = express();
// // const port = 8000;
//  // app.use(express.json());
//  // // Endpoints
// // app.get('/', (req, res) => {
// //     res.send('hello world');
// // });
//  // app.get('/student/assignments', (req, res) => {
// //     db('assignments')
// //         .then(assignments => {
// //             res.status(200).json(assignments)
// //         })
// //         .catch(err => {
// //             res.status(500).json(err);
// //         })
// // });

// ================================================== EVAN ========================================================================= 

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
const settings = {timestamptsInSnapshots: true};
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

// POST

// app.post('/teachers', async (req, res, next) => {
//   try {
//     const name = req.body;
//     // if(!name) throw new Error('Name is blank!');
//     const teacherData = { name };
//     const teachersRef = await db.collection('teachers').add(teacherData);
//     res.json({
//       id: teachersRef.id,
//       teacherData
//     });
//   } catch(err) {
//     console.log(err.message);
//     next(err);
//   }
// });

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

/////////////////////// STUDENTS /////////////////////////////////////////////

app.get('/:id/assignments', async (req, res, next) => {
        try {
        const studentId = req.params.id;
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


// const field_list = ["dueDate", "feedback","instructions", "instrument", "level", "piece","sheetMusic","status","teacher", "video"];
// collection = db.collection('students').doc("NKMNNypkVXUj4BSSyTPb").collection('assignments').doc('jKqbaQTm5lQikF6MMD9K').get()
//     .then(function(res) {
//         field_list.forEach(function(field){
//             console.log([field, ":", res.get(field)].join(' '))
//          })
// })


// server instantiation

const server = app.listen(8000, function () {

  const host = server.address().address;
  const port = server.address().port;

  console.log(`Server listening on port ${port}.`);
});
