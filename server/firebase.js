const firebase = require('firebase-admin');
const serviceAccount = require('./musicmaker-4b2e8-firebase-adminsdk-v1pkr-34d1984175.json');

firebase.initializeApp({
  credential: firebase.credential.cert(serviceAccount),
  databaseURL: 'https://musicmaker-4b2e8.firebaseio.com',
});

module.exports = firebase;
