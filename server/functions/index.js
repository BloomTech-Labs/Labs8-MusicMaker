//Hosting URL: https://musicmaker-4b2e8.firebaseapp.com
const functions = require("firebase-functions");
const firebase = require("firebase-admin");
const express = require("express");
const cors = require("cors");
const stripe = require("stripe")("sk_test_YwuqJTfx2ZxOo4hGqGQSnoP3");
const fileUpload = require("express-fileupload");
const UUID = require("uuid-v4");
const QRCode = require("qrcode");

const serviceAccount = "serviceAccountKey.json";

firebase.initializeApp({
  apiKey: "AIzaSyCls0XUsqzG0RneHcQfwtmfvoOqHWojHVM",
  authDomain: "musicmaker-4b2e8.firebaseapp.com",
  databaseURL: "https://musicmaker-4b2e8.firebaseio.com",
  projectId: "musicmaker-4b2e8",
  storageBucket: "musicmaker-4b2e8.appspot.com",
  messagingSenderId: "849993185408"
});

const db = firebase.firestore();
const projID = "musicmaker-4b2e8";

const Firestore = require("@google-cloud/firestore");
const firestore = new Firestore({
  projectId: projID
});
const settings = { timestampsInSnapshots: true };
firestore.settings(settings);

const { Storage } = require("@google-cloud/storage");
const storage = new Storage({
  projectId: projID,
  keyFilename: serviceAccount
});
const bucket = storage.bucket("gs://musicmaker-4b2e8.appspot.com");

const app = express();
app.use(express.json());
app.use(cors());
app.use(fileUpload({
    createParentPath: true
  })
);

//=======================================================================================================================================================================
// FUNCTION(S) ###########################################################################################################################################################
function parseDate(date) {
  const month = date.getMonth() + 1;
  const day = date.getDate() + 1;
  const year = date.getFullYear();
  // const hour = date.getHours() > 12 ? date.getHours() - 12 : date.getHours(); //fixing custom time at a later time
  // const minute = date.getMinutes() == "0" ? "00" : date.getMinutes(); //fixing custom time at a later time
  // const amPm = date.getHours() >= 12 ? "PM" : "AM"; //fixing custom time at a later time
  const reformattedDueDate =
    month + "/" + day + "/" + year + " at 11:59 PM";
    // month + "/" + day + "/" + year + " at " + hour + ":" + minute + " " + amPm; //fixing custom time at a later time
  return reformattedDueDate;
}

//STUDENT LIST: GET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

//GET should retrieve a teacher's list of students
//details: name, instrument, level, email
app.get("/teacher/:uid/students", (req, res) => {
  try {
    const uid = req.params["uid"]; //teacher id 
    let promises = [];

    //teacher's db referencing their students:
    const teacherStudentsRef = db.collection("teachers").doc(uid).collection("students"); 
    //students' db:
    const studentRef = db.collection("students"); 

    teacherStudentsRef
    .get()
    .then(students => {
      students.forEach(student => {
        const promise = studentRef.doc(student.id).get();
        promises.push(promise);
      });

      Promise
        .all(promises)
        .then(results => {
          const students = results.map(student => {
            return [student.id, student.data()];
          });
          res.status(200).json(students);
        })
        .catch(err => res.status(500).json(err));
    });

  } catch (err) {
    res.status(500).send(err);
  }
});

// Get an individual student assigned to the teacher
//details: name, instrument, level, email
app.get("/teacher/:uid/student/:sid", (req, res) => {
  try {
    const uid = req.params["uid"]; //teacher id
    const sid = req.params["sid"]; //student id

    //teacher's db referencing their student:
    const teacherStudentRef = db.collection("teachers").doc(uid).collection("students").doc(sid);
    //students' db:
    const studentRef = db.collection("students"); 

    teacherStudentRef
    .get()
    .then(student => {
      studentRef.doc(student.id).get()
      .then(settings => {
        res.status(200).json(settings.data())
      });
    });

  } catch (err) {
    res.status(500).send(err);
  }
});

// Get the list of assignments from a student
app.get("/teacher/:uid/student/:sid/assignments",(req, res) => {
    try {
      const uid = req.params["uid"]; //teacher id
      const sid = req.params["sid"]; //student id
      const assignments = [];

      //Student's assignments db reference:
      const studentAssignmentsRef = db.collection("students").doc(sid).collection("teachers").doc(uid).collection("assignments");
      
      studentAssignmentsRef
        .orderBy('dueDate', 'asc')
        .get()
        .then(snap => {
          snap.forEach(doc => {
            global = doc.data();
            reformattedDueDate = parseDate(global.dueDate);
            assignments.push([ 
              doc.id,
              global.assignmentName,
              reformattedDueDate,
              global.instrument,
              global.level,
              global.piece,
              global.instructions,
              global.sheetMusic,
              global.video,
              global.feedback,
              global.grade
            ])
            

          });
          res.status(200).json(assignments);
        });

    } catch (err) {
      res.status(500).send(err);
    }
  }
);

// Get a list of students currently assigned to an assignment
//details: student settings info. and student's assignment info.
//Frontend: Need to reformat date so that it's properly visible and have it listed newest to oldest assignment
app.get("/teacher/:uid/assignment/:aid/students", (req, res) => {
  try {
    const uid = req.params["uid"]; //teacher id
    const aid = req.params["aid"]; //assignment id
  
    //Teacher's db list of students:
    const teacherStudentsRef =  db.collection('teachers').doc(uid).collection('assignments').doc(aid).collection('students');
    //Student db:
    const studentRef = db.collection('students'); 

    teacherStudentsRef
      .get()
      .then(students => {
        const promises = [];
        students.forEach(student => {
          const sid = student.id;

          const studentPromise = studentRef.doc(sid).get().then(student => {
            return studentRef.doc(sid).collection('teachers').doc(uid).collection('assignments').doc(aid).get().then(assignment => {
              const studentInfo = student.data();
              const assignmentInfo = assignment.data();
              const reformattedDueDate = parseDate(assignmentInfo.dueDate);

              return [assignment.id, assignmentInfo.assignmentName, student.id, studentInfo.firstName, studentInfo.lastName, reformattedDueDate, assignmentInfo.video, assignmentInfo.grade]
            });
          });

          promises.push(studentPromise);
        });

        Promise.all(promises).then(results => {
          res.status(200).json(results);
        });
      });
      
  } catch (err) {
    res.status(500).send(err);
  }
});

// GRADE ASSIGNMENT: GET - PUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&&&&&&&&&&&&&&&&&&&&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Get a completed/uncompleted assignment from a student
//details: all assignment information
app.get("/teacher/:uid/assignment/:aid/student/:sid",(req, res) => {
    try {
      const uid = req.params["uid"]; //teacher id
      const aid = req.params["aid"]; //assignment id
      const sid = req.params["sid"]; //student id

      //Student's assignment db reference:
      const studentAssignmentRef = db.collection("students").doc(sid).collection("teachers").doc(uid).collection("assignments").doc(aid);
      
      studentAssignmentRef
        .get()
        .then(assignment => {
          global = assignment.data();
          reformattedDueDate = parseDate(global.dueDate);
          studentAssignment = [
            global.assignmentName,
            reformattedDueDate,
            global.instrument,
            global.level,
            global.piece,
            global.instructions,
            global.sheetMusic,
            global.video,
            global.feedback,
            global.status
          ];

          res.status(200).json(studentAssignment);
        });

    } catch (err) {
      res.status(500).send(err);
    }
  }
);

// PUT should add feedback and grade (pass/fail) to a student's assignment
app.put("/teacher/:uid/assignment/:aid/student/:sid", (req, res) => {
    try {
      const uid = req.params["uid"]; //teacher id
      const aid = req.params["aid"]; //assignment id
      const sid = req.params["sid"]; //student id
      const { feedback, grade } = req.body;

      //Student's assignment db reference:
      const studentAssignmentRef = db.collection("students").doc(sid).collection("teachers").doc(uid).collection("assignments").doc(aid)

      if (!feedback || !grade) {
        res.status(411).send({REQUIRED: "You must have all fields filled: grade and feedback."});
      } else {
        studentAssignmentRef
          .update({
            'feedback': feedback,
            'grade': grade
          });

        res.status(202).send({ MESSAGE: "You have successfully graded this assignment." });
      }

    } catch (err) {
      res.status(500).send(err);
    }
  }
);

// ASSIGN STUDENT TO AN ASSIGNMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

//POST Teacher's will be able to give student(s) an assignment
//details: assignment name, instructions, instrument, level, music sheet and piece
app.post("/teacher/:uid/assignment/:aid/assignToStudent", (req, res) => {
    try {
      const uid = req.params["uid"]; //teacher id
      const aid = req.params["aid"]; //assignment id
      const { email, dueDate } = req.body;

      //student db:
      const studentRef = db.collection("students"); 
      //Teacher's assignment db reference:
      const teacherAssignmentRef = db.collection("teachers").doc(uid).collection("assignments").doc(aid); 

      studentRef
        .where("email", "==", email)
        .get()
        .then(students => {
          students.forEach(student => {
            const sid = student.id;
            //Student's teacher assignment db reference:
            const studentTeacherAssignmentRef = studentRef.doc(sid).collection("teachers").doc(uid).collection("assignments").doc(aid); 
            
            // Lets teacher store that the student has been given the assignment
            teacherAssignmentRef
              .collection('students')
              .doc(sid)
              .set({
                'assigned': true
              })

            // Gives assigment information to student with their due date
            teacherAssignmentRef
              .get()
              .then(assignment => {
                studentTeacherAssignmentRef
                  .set(assignment.data());
              })
              .then(() => {
                studentTeacherAssignmentRef
                  .update({
                    'dueDate': new Date(dueDate)
                  });
              });

            res.status(201).send({MESSAGE: "Student has successfully been added to assignment." });
          });
        });

    } catch (err) {
      res.status(500).send(err);
    }
  });

// UNGRADED ASSIGNMENTS : POST - GET (All & Single Ungraded Assignment) - DELETE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// POST should create and add a new ungraded assignment under a teacher
// details: assignmentName, instructions, instrument, level, piece, sheetMusic
app.post("/teacher/:uid/createAssignment", (req, res) => {
  try {
    const uid = req.params["uid"]; //teacher id
    const { assignmentName, instructions, instrument, level, piece } = req.body;

    //Teacher's assignments db reference:
    const teacherAssignmentRef = db.collection("teachers").doc(uid).collection("assignments"); 

    // if (!assignmentName || !instructions || !instrument || !level || !piece) {
    //   res.status(411).send({ REQUIRED: "You must have all fields filled." });
    // } else {
      teacherAssignmentRef
        .add({
          'assignmentName': assignmentName,
          'instructions': instructions,
          'instrument': instrument,
          'level': level,
          'piece': piece
        })
        .then(assignment => {
          if (Object.keys(req.files).length == 0) {
            return res.status(400).send({ MESSAGE: "No file was uploaded." });
          }
          let uuid = UUID();
          let uploadFile = req.files.file;
          let name = uploadFile.name;

          uploadFile.mv("/tmp/" + name);

          bucket
            .upload("/tmp/" + name, {
              destination: "sheetMusic/" + name,
              metadata: {
                metadata: {firebaseStorageDownloadTokens: uuid}
              }
            })
            .then(data => {
              let file = data[0];
              Promise.resolve(
                "https://firebasestorage.googleapis.com/v0/b/" + bucket.name + "/o/" + encodeURIComponent(file.name) + "?alt=media&token" + uuid
              ).then(url => {
                teacherAssignmentRef
                  .doc(assignment.id)
                  .update({
                    'sheetMusic': url
                  });
                res.status(201).send({ MESSAGE: `You have successfully created ${assignmentName}.`}); 
              });
            });
        });
    // }

  } catch (err) {
    res.status(500).send(err);
  }
});

//GET should retrieve teacher's all ungraded assignments
//details: assignmentName, instructions, instrument, level, piece, sheetMusic
app.get("/teacher/:uid/assignments", (req, res) => {
  try {
    const uid = req.params["uid"]; //teacher id
    const allAssignments = [];

    // Teacher's assignments db reference:
    const teacherAssignmentsRef = db.collection("teachers").doc(uid).collection("assignments");

    teacherAssignmentsRef
    .get()
    .then(assignments => {
      assignments.forEach(assignment => {
        allAssignments.push([assignment.id, assignment.data()]);
      });

      res.status(200).json(allAssignments);
    });

  } catch (err) {
    res.status(500).send(err);
  }
});

//GET should retrieve teacher's single ungraded assignment
//details: assignmentName, instructions, instrument, level, piece
app.get("/teacher/:uid/assignment/:aid", (req, res) => {
  try {
    const uid = req.params["uid"]; //teacher id
    const aid = req.params["aid"]; //assignment id

    // Teacher's assignment db reference:
    const teacherAssignmentRef = db.collection("teachers").doc(uid).collection("assignments").doc(aid); 

    teacherAssignmentRef
    .get()
    .then(doc => {
      res.status(200).json(doc.data());
    });

  } catch (err) {
    res.status(500).send(err);
  }
});

app.delete("/teacher/:uid/assignment/:aid", (req, res) => {
  try {
    const uid = req.params["uid"]; //teacher id
    const aid = req.params["aid"]; //assignment id

    // Teacher's assignment db reference:
    const teacherAssignmentRef = db.collection("teachers").doc(uid).collection("assignments").doc(aid); 

    if (!aid){
      res.status(404).send({MESSAGE: 'This assignment has already been deleted.'})
    }else {
      teacherAssignmentRef
      .delete()
      .then(() => {
        res.status(204).send({MESSAGE: 'Your assignment has been successfully deleted.'})
      });
    };

  } catch (err) {
    res.status(500).send(err); 
  }
});

//SETTINGS : POST - GET - PUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

//POST should create and add a new teacher's settings info.
//details: email, name (first, last, and prefix), and generate a new qr code
app.post("/addNewTeacher/:uid", (req, res) => {
  try {
    console.log("\n****\n", req.params, req.body)
    const { uid } = req.params;
    const { email, firstName, lastName, prefix } = req.body;

    //Teachers' db reference:
    const teachersRef = db.collection("teachers") 

    if (!email) {
      res.status(411).send({REQUIRED: "Please fill all required fields: email missing."});
    } else {
      teachersRef
        .doc(uid)
        .set({
          'email': email,
          'subscribed': false
        })
        .then(ref => {
          let uuid = UUID();
          let qrOptions = {
            errorCorrectionLevel: "H",
            type: "image/jpeg",
            rendererOpts: {quality: 0.3}
          };
          const qrPath = "/tmp/signup_" + email + ".jpg";
          QRCode.toFile(qrPath, uid, qrOptions);

          bucket
            .upload(qrPath, {
              destination: "qrCodes/" + email,
              metadata: {
                metadata: {firebaseStorageDownloadTokens: uuid}
              }
            })
            .then(data => {
              let file = data[0];
              Promise.resolve(
                "https://firebasestorage.googleapis.com/v0/b/" + bucket.name + "/o/" + encodeURIComponent(file.name) + "?alt=media&token" + uuid
              ).then(url => {
                teachersRef
                  .doc(uid)
                  .update({
                    'qrcode': url
                  });
                  
                  res.status(201).send({MESSAGE: `Teacher ${email} was successfully added.`});
                });
            });
        });
    }

  } catch (err) {
    res.status(500).send(err);
  }
});

//GET should retrieve teachers settings info.
//details: email, name (first, last, and prefix), and qr code
app.get("/teacher/:uid/settings", (req, res) => {
  try {
    const uid = req.params["uid"]; //teacher id

    //Teacher's db reference:
    const teacherRef = db.collection("teachers").doc(uid); 

    teacherRef
      .get()
      .then(settings => {
        res.status(200).json(settings.data());
      });

  } catch (err) {
    res.status(500).send(err);
  }
});

//PUT should update teachers settings info.
//details: name (first, last, and prefix)
app.put("/teacher/:uid/settingsEdit", (req, res) => {
  try {
    const uid = req.params["uid"]; //teacher id
    const { firstName, lastName, prefix } = req.body;

    //Teacher's db reference:
    const teacherRef = db.collection("teachers").doc(uid); 

    if (!prefix || !firstName || !lastName) {
      res.status(411).send({REQUIRED: `Prefix, first and/or last name cannot be left empty.`});
    } else {
      teacherRef
        .update({
          name: {
            firstName: firstName,
            lastName: lastName,
            prefix: prefix
          }
        });
        
      res.status(202).send({ MESSAGE: "You have successfullly updated your information." });
    }

  } catch (err) {
    res.status(500).send(err);
  }
});

// STRIPE IMPLEMENTATION - POST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

//POST Teacher can make a payment to subscribe to app 
//details: in db it'll show that the teacher has payed
app.post("/teacher/:uid/charge", (req, res) => {
  try {   
    const uid = req.params["uid"]; //teacher id

    //Teacher's db reference:
    const teacherRef = db.collection("teachers").doc(uid); 

    let { status } = stripe.charges.create({
      amount: 50,
      currency: "usd",
      description: "teacher subscription",
      source: req.body.token.id
    })
    .then(() => {
      teacherRef
        .update({
          'subscribed': true
        })
    }) 

    res.status(201).json({ status });
  } catch (err) {
    res.status(500).send(err);
  }
});

//=======================================================================================================================================================================

app.listen(8000, () => {
 console.log('\n======================== RUNNING ON PORT 8000 =========================\n')   
});

exports.app = functions.https.onRequest(app);
