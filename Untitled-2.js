// QR Code 
let qrOptions = {
  errorCorrectionLevel: 'H',
  type: 'image/jpeg',
  rendererOpts: {
    quality: 0.3
  }
}
app.post('/teacher/add', (req, res, next) => {
  try {
    const email = req.body.email;
    const firstName =  req.body.firstName;
    const lastName =  req.body.lastName;
    let uuid = UUID();
     if(!email) {
      res.status(411).send({ error: 'Please fill out all required fields. Email address is missing.' });
    } else if(!firstName || !lastName) {
      res.status(411).send({ error: 'Please fill out all required fields. First and/or last name is missing.' });
    } else {
      
      const teachersRef = db.collection('teachers').add({
        'email': email,
        'name': {
          'firstName': firstName,
          'lastName': lastName
        },
        'qrcode': 'Not Assigned'
      }).then(ref =>{

      const qrPath = '/tmp/signup_' + lastName + '.jpg'
      const qr = QRCode.toFile(qrPath,ref.id, qrOptions);
      
      bucket.upload(qrPath , {
        destination : 'qrCodes/' + email,
        metadata : {
          metadata:{
            firebaseStorageDownloadTokens : uuid
          }
        }
      }).then((data) =>{
    let file = data[0]
    Promise.resolve("https://firebasestorage.googleapis.com/v0/b/" + bucket.name + "/o/" + encodeURIComponent(file.name) + "?alt=media&token" + uuid)
    .then(url => {
      const teachersRef = db.collection('teachers').doc(ref.id).update({
        'qrcode': url
      })
      res.status(200).send({ message: 'Teacher successfully added! : ' + url })

        
      })
  
    })
      }
    
        
      )
      
    }
  }
   catch(err) {
    next(err);
  }


  

  
});
