import { auth } from './FirebaseConfig';

// Sign up and create new user account
export const doCreateUserWithEmailAndPassword = (email, password) => 
    auth.createUserWithEmailAndPassword(email, password);

// Sign in with a user account
export const doSignInWithEmailAndPassword = (email, password) => 
    auth.signInWithEmailAndPassword(email, password);

// Sign out from a user account
export const doSignOut = () =>
    auth.signOut();

// Reset password
export const doPasswordReset = (email) => 
    auth.sendPasswordResetEmail(email);

// Update password
export const doPasswordUpdate = (password) =>
    auth.currentUser.updatePassword(password);