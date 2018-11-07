const https = require('https');
var admin = require("firebase-admin");
var functions = require('firebase-functions');

// const serviceAccount = require("./private_key.json");

//  admin.initializeApp({
//      credential: admin.credential.cert(serviceAccount),
//      databaseURL: 'https://musicmaker-4b2e8.firebaseio.com'
//    });



// var db = admin.firestore();
// var students = db.collection('students').doc('NKMNNypkVXUj4BSSyTPb').collection('assignments').doc('jKqbaQTm5lQikF6MMD9K').sheetMusic
// //db.ref().set({'name' : 'test'});

// console.log("THIS", students);

var serviceAccount = require("./private_key.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});


var db = admin.firestore();
// collection = db.collection('students').get().then(function(student) {
//     student.forEach(function(doc){
//         console.log(doc.data())
        
//     })
// });

collection = db.collection('students').doc("NKMNNypkVXUj4BSSyTPb").collection('assignments').get().then(function(student) {
    student.forEach(function(doc){
        console.log(doc.data)
    })
});

var field_list = ["dueDate", "feedback","instructions", "instrument", "level", "piece","sheetMusic","status","teacher", "video"];
collection = db.collection('students').doc("NKMNNypkVXUj4BSSyTPb").collection('assignments').doc('jKqbaQTm5lQikF6MMD9K').get()
    .then(function(res) {
        field_list.forEach(function(field){
            console.log([field, ":", res.get(field)].join(' '))

        })
})



// let baseUrl = 'https://firestore.googleapis.com/v1beta1/'
// https.get(firebaseEndpoint, (resp) => {
//     let data = '';
    
//     resp.on('data', (chunk) => {
//         data += chunk;
//     });

//     resp.on('end', () => {
//         console.log(JSON.parse(data).explanation);
//     });
// }).on('error', (error) => {
//     console.log('ERROR:' + err.message);
// });

// const port = 8000;

// exports.studentAssignments = functions.https.onRequest(req, res) => {
//     res.status(200).send()
// }


// app.listen(port, () => {
//     console.log(`\n===== RUNNING ON PORT ${port} =====\n`);
// });

// const express = require('express');

// const app = express();
// const port = 8000;

// app.use(express.json());

// // Endpoints
// app.get('/', (req, res) => {
//     res.send('hello world');
// });

// app.get('/student/assignments', (req, res) => {
//     db('assignments')
//         .then(assignments => {
//             res.status(200).json(assignments)
//         })
//         .catch(err => {
//             res.status(500).json(err);
//         })
// });



