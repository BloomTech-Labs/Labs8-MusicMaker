import firebase from 'firebase/app';
import 'firebase/auth';

const FirebaseConfig = {
    apiKey: "AIzaSyCls0XUsqzG0RneHcQfwtmfvoOqHWojHVM",
    authDomain: "musicmaker-4b2e8.firebaseapp.com",
    databaseURL: "https://musicmaker-4b2e8.firebaseio.com",
    projectId: "musicmaker-4b2e8",
    storageBucket: "musicmaker-4b2e8.appspot.com",
    messagingSenderId: "849993185408",
    // clientId: "ca6a9322899eb2e3a02f355415650bee2b293ec5.apps.googleusercontent.com",
    // scopes: [
    //     "email",
    //     "profile",
    // ],
};

if(!firebase.apps.length) firebase.initializeApp(FirebaseConfig);

const auth = firebase.auth();

export {
    auth,
};