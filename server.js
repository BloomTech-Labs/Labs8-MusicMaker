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
var storage = require('@google-cloud/storage');
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

app.get('/student/:id', async (req, res, next) => {
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

  app.get('/student/:id_student/assigment/:id_assignment', async (req, res, next) => {
    try {
        const studentId = req.params['id_student'];
        const assignmentId = req.params['id_assignment'];

        const string_list = ["feedback","instructions", "instrument", "level", "piece","sheetMusic","status","teacher", "video"];
        const assigmentRef =  await db.collection('students').doc(studentId).collection('assignments').doc(assignmentId).get()

        json_res = {};
        for (let i =0; i < string_list.length; i++){
            let value = assigmentRef.get(string_list[i]);
            if(!("object" == typeof(value))){
                json_res[string_list[i]] = value;
            }else{
                console.log("Error: Should not have object in this list")
            }
        }
        let dueDate = assigmentRef.get("dueDate");
        json_res["dueDate"] = dueDate;

        
        // let musicSheet = assigmentRef.get("sheetMusic");
        // let segments = musicSheet['0']._key.path.segments
        // let dir_name = segments[segments.length -2];
        // let filename = segments[segments.length -1];
        // //console.log(musicSheet['0']._key.path.segments);

        // var gsReference = storage.refFromURL('gs://musicmaker-4b2e8.appspot.com/' + dir_name + '/' + filename);

        // //gs://musicmaker-4b2e8.appspot.com
        // gs://musicmaker-4b2e8.appspot.com
        
        res.json(json_res);
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
