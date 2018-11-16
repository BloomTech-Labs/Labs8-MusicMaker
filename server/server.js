const admin = require('firebase-admin');
const express = require('express');
const QRCode = require('qrcode');
const fs = require('fs');
const cors = require('cors');
const corsOptions = {
    origin: '*',
    optionsSuccessStatus: 200 // some legacy browsers (IE11, various SmartTVs) choke on 204
}

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

const storage = require('@google-cloud/storage')({
  projectId: 'musicmaker-4b2e8'
});

///////////////////////

const app = express();
app.use(cors(corsOptions));

// GET a QR code

app.get('/qrcode', async (req, res, next) => {
  try {
    let stringGen = Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, 16);
    let code = QRCode.toString(stringGen, function (err, string) {
      console.log(string);
      res.json(string);
    })
  } catch(err) {
    next(err);
  }
});

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

//GET teacher can get an assignment's sheetMusic(pdf)
app.get('/teacher/:idTeacher/assigment/:idAssignment/sheetMusic', async (req, res, next) => {
  try {
      const teacherId = req.params['idTeacher'];
      const assignmentId = req.params['idAssignment'];
  
      const assignmentRef =  await db.collection('teachers').doc(teacherId).collection('assignments').doc(assignmentId).get();

      const musicSheet = assignmentRef.get("sheetMusic");
      const segments = musicSheet['0']._key.path.segments
      const dirName = segments[segments.length -2];
      const filename = segments[segments.length -1];
      const options = {
          destination : 'temp/' + teacherId + '_' + filename,
      };

      const bucket = await storage.bucket('musicmaker-4b2e8.appspot.com');
      await storage.bucket('musicmaker-4b2e8.appspot.com')
                   .file(dirName + '/' + filename)
                   .download(options);

      const displaysFile = await fs.readFile('temp/' + teacherId + '_' + filename, (err, data) => {
        res.contentType("application/pdf");
        res.send(data);
      });

  } catch (err) {
  next (err);
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

// app.post('/teachers', (req, res) => {
//   let data = {
//     QRCode: req.QRCode,
//     email: req.email
//   };
//
//   let setTeacher = db.collection('teachers').set(data);
//   res.json(data);
// })

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
// function parseDate(date){
//   const month = date.getMonth() + 1;
//   const day = date.getDate() + 1;
//   const year = date.getFullYear();
//   const hour = date.getHours() > 12 ? date.getHours() - 12 : date.getHours();
//   const minute = date.getMinutes() == '0' ? '00' : date.getMinutes();
//   const amPm = date.getHours() >= 12 ? "PM" : "AM";
//   const reformattedDueDate = month + "/" + day + "/" + year + " at " + hour + ":" + minute + " " + amPm
//   return reformattedDueDate;
// };

// // GET list of all of student's assignments, details: assignmentName, dueDate, and status
// app.get('/student/assignments/:idStudent', async (req, res, next) => {
//   try {
//   const studentId = req.params['idStudent'];
//   const assignments = {};

//   const assignmentsRef =  await db.collection('students').doc(studentId).collection('assignments').orderBy('dueDate', 'desc');
//   const allAssignments = await assignmentsRef.get()
//   .then(snap => {
//     snap.forEach(doc => {
//       root = doc.data();
//       reformattedDueDate = parseDate(root.dueDate);
//       assignments[doc.id] = [root.assignmentName, reformattedDueDate, root.status];
//     })
//   })

//   res.json(assignments);

//   } catch(err) {
//   next(err);
//   }
// });

// //GET a single assignment from a student, details: assignmentName, dueDate, teacher, instrument, level, piece, instructions, feedback
// app.get('/student/:idStudent/assigment/:idAssignment', async (req, res, next) => {
//   try {
//       const studentId = req.params['idStudent'];
//       const assignmentId = req.params['idAssignment'];
//       const assignment = {};      

//       const assignmentRef =  await db.collection('students').doc(studentId).collection('assignments').doc(assignmentId);
//       const getDoc = await assignmentRef.get()
//       .then(doc => {
//         root = doc.data();
//         reformattedDueDate = parseDate(root.dueDate);
//         assignment[doc.id] = [root.assignmentName, reformattedDueDate, root.teacher, root.instrument, root.level, root.piece, root.instructions, root.feedback]
//       })

//       res.json(assignment);

//   } catch (err) {
//   next (err);
//   }
//   });

// //GET student can get their sheetMusic(pdf)
// app.get('/student/:idStudent/assigment/:idAssignment/sheetMusic', async (req, res, next) => {
//   try {
//       const studentId = req.params['idStudent'];
//       const assignmentId = req.params['idAssignment'];
  
//       const assignmentRef =  await db.collection('students').doc(studentId).collection('assignments').doc(assignmentId).get();

//       const musicSheet = assignmentRef.get("sheetMusic");
//       const segments = musicSheet['0']._key.path.segments
//       const dirName = segments[segments.length -2];
//       const filename = segments[segments.length -1];
//       const options = {
//           destination : 'temp/' + studentId + '_' + filename,
//       };

//       const bucket = await storage.bucket('musicmaker-4b2e8.appspot.com');
//       await storage.bucket('musicmaker-4b2e8.appspot.com')
//                    .file(dirName + '/' + filename)
//                    .download(options);

//       const displaysFile = await fs.readFile('temp/' + studentId + '_' + filename, (err, data) => {
//         res.contentType("application/pdf");
//         res.send(data);
//       });

//   } catch (err) {
//   next (err);
//   }
//   });

// //GET student can get their recorded video
// app.get('/student/:idStudent/assigment/:idAssignment/video', async (req, res, next) => {
//   try {
//       const studentId = req.params['idStudent'];
//       const assignmentId = req.params['idAssignment'];
  
//       const assignmentRef =  await db.collection('students').doc(studentId).collection('assignments').doc(assignmentId).get();

//       const video = assignmentRef.get("video");
//       const segments = video['0']._key.path.segments;
//       const dirName = segments[segments.length -2];
//       const filename = segments[segments.length -1];
//       const storagePath = dirName + '/' + filename; 
//       const localPath = 'temp/' + studentId + '_' + filename;
//       const options = {
//           destination : localPath,
//       };

//       const bucket = await storage.bucket('musicmaker-4b2e8.appspot.com');
//       await storage.bucket('musicmaker-4b2e8.appspot.com')
//                    .file(storagePath)
//                    .download(options);

//       const displaysVideo = await fs.readFile(localPath, (err, data) => {
//         res.contentType("video/mov");
//         res.send(data);
//       });

//   } catch (err) {
//   next (err);
//   }
//   });

// server instantiation

const server = app.listen(8000, function () {

  const host = server.address().address;
  const port = server.address().port;

  console.log(`Server listening on port ${port}.`);
});
