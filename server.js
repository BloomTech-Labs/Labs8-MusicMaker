const functions = require('firebase-functions');
const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();
// const serviceAccount = require("./private_key.json");
// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
// });


const express = require('express');
const app = express();
app.use(express.json());
const port = 8000;



// const serviceAccount = require("./private_key.json");

//  admin.initializeApp({
//      credential: admin.credential.cert(serviceAccount),
//      databaseURL: 'https://musicmaker-4b2e8.firebaseio.com'
//    });



// const db = admin.firestore();
// const students = db.collection('students').doc('NKMNNypkVXUj4BSSyTPb').collection('assignments').doc('jKqbaQTm5lQikF6MMD9K').sheetMusic
// //db.ref().set({'name' : 'test'});

// console.log("THIS", students);



// collection = db.collection('students').get().then(function(student) {
//     student.forEach(function(doc){
//         console.log(doc.data())
        
//     })
// });

// collection = db.collection('students').doc("NKMNNypkVXUj4BSSyTPb").collection('assignments').get().then(function(student) {
//     student.forEach(function(doc){
//         console.log(doc.data)
//     })
// });

// const field_list = ["dueDate", "feedback","instructions", "instrument", "level", "piece","sheetMusic","status","teacher", "video"];
// collection = db.collection('students').doc("NKMNNypkVXUj4BSSyTPb").collection('assignments').doc('jKqbaQTm5lQikF6MMD9K').get()
//     .then(function(res) {
//         field_list.forEach(function(field){
//             console.log([field, ":", res.get(field)].join(' '))
//         })
// })



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

// exports.studentAssignments = functions.https.onRequest(req, res) => {
//     res.status(200).send()
// }


app.listen(port, () => {
    console.log(`\n===== RUNNING ON PORT ${port} =====\n`);
});


// Endpoints
app.get('/', (req, res) => {
    res.send('hello world');
});

// app.get('/', (req, res) => {
//     const collection = db.collection('students').doc("NKMNNypkVXUj4BSSyTPb").get();
//     console.log('**********', collection);
//     return collection;

    // .get()
    // .then(function(student) {
    //     student.forEach(function(doc){
    //         res.status(200).json(doc.get())
    //     })
    // })
    
// });





