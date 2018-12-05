// ASSIGN STUDENT TO AN ASSIGNMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

app.post('/teacher/:idTeacher/assignment/:idAssignment/assignToStudent', (req, res) => {
  try {
    const teacherId = req.params['idTeacher'];
    const assignmentId = req.params['idAssignment'];
    const { email, dueDate } = req.body;

    const studentRef = db.collection('students').where('email', '==', email);
    const getDoc = studentRef.get()
      .then(snap =>{
        snap.forEach(doc => {
          const studentId = doc.id

          // const assignmentTeacherRef = db.collection('teachers').doc(teacherId).collection('assignments').doc(assignmentId).collection('students').doc(studentId).set({
          //   // name: {
          //   //   'firstName': firstName,
          //   //   'lastName': lastName
          //   // },
          //   'dueDate': new Date(dueDate) 
          // })

          // const AssignmentRef = db.collection('students').doc(studentId);
          // const getAsn = AssignmentRef.get()
          // .then(asn  => {
          // console.log('here****************************************', [asn.data().firstName, asn.data().lastName])
          // const teacherAssignmentRef = db.collection('teachers').doc(teacherId).collection('assignments').doc(assignmentId).collection('students').doc(studentId).set(snap.data());            
          // }).then(() => {
          //   const teacherAssignmentRef = db.collection('teachers').doc(teacherId).collection('assignments').doc(assignmentId).collection('students').doc(studentId).update({
          //     'dueDate': new Date(dueDate) 
          //   })
          // })

          // gives assignment to student
          const assignmentRef =  db.collection('teachers').doc(teacherId).collection('assignments').doc(assignmentId);
          const getDoc = assignmentRef.get()
          .then(doc => {
            const studentAssignmentRef = db.collection('students').doc(studentId).collection('teachers').doc(teacherId).collection('assignments').doc(assignmentId).set(doc.data())
          }).then(() => {
            const studentAssignmentRef = db.collection('students').doc(studentId).collection('teachers').doc(teacherId).collection('assignments').doc(assignmentId).update({
              'dueDate': new Date(dueDate) 
            })
          })

          res.status(201).send({MESSAGE: 'Student has successfully been added to assignment.'})
      })    
  });

  }catch(err){
    res.status(500).send(err);
  };
});
