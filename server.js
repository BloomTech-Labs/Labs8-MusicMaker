const express = require('express');

// Firebase-specific dependencies

const firebase = require('firebase');
const config = {
  apiKey: "AIzaSyA-0FrKFRAPkMvFTTdFzrAKJZDrE-XrwhE",
   authDomain: "testdb-6e089.firebaseapp.com",
   databaseURL: "https://testdb-6e089.firebaseio.com",
   projectId: "testdb-6e089",
   storageBucket: "",
   messagingSenderId: "274645799385"
};
firebase.initializeApp(config);

///////////////////////

const app = express();

// test GET request, adding key/value pair to Firebase

app.get('/', (req, res) => {
  console.log('GET request test');
  res.send('hello!');

  firebase.database().ref('/Tests').set({Test: 'Hello world!' });
});

// GET and GET by id

app.get('/', (req, res) => {
  console.log('GET test');
  res.send('hello!');
});

app.get('/:id', (req, res) => {
  console.log('GET by id test');
  res.send('hello!');
});

///////////////////////

// POST

app.post('/', (req, res) => {
  console.log('POST test');

  var username = req.body.username;
  var email = req.body.email;

  var referencePath = 'Users/+username+';
  var userReference = firebase.database().ref(referencePath);
  userReference.set({Username: username, Email: email }),
  function(err) {
    if(err) {
      res.send('An error was encountered while posting the data.' + err);
    } else {
      res.send('User saved successfully!');
    }
  };
});

///////////////////////

// PUT

app.put('/', (req, res) => {
  console.log('PUT test');
  res.send('hello!');
});

///////////////////////

// DELETE

app.delete('/', (req, res) => {
  console.log('DELETE test');
  res.send('hello!');
});

///////////////////////

// server instantiation

const server = app.listen(8000, function () {

  const host = server.address().address;
  const port = server.address().port;

  console.log(`Server listening on port ${port}.`);
});
