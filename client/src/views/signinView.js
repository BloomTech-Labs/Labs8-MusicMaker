import React, { Component } from 'react';
// import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import firebase from 'firebase/app';

import { auth } from '../firebase';
import * as routes from '../constants/routes';
import { SignUpLink } from './signupView';
import ForgotPW from '../components/ForgotPW';

const SignInPage = ({ history }) =>
    <div>
        <h1>Sign In</h1>
        <SignInView history = { history } />
        <SignUpLink />
        <ForgotPW />
    </div>

const byPropKey = (propertyName, value) => () => ({
    [propertyName]: value,
});

const INITIAL_STATE = {
    email: '',
    password: '',
    error: null
};

class SignInView extends Component {
    constructor(props) {
        super(props);

        this.state = { ...INITIAL_STATE };
    }

    onSubmit = (event) => {
        const {
            email,
            password,
        } = this.state;

        const {
            history,
        } = this.props;

        auth.doSignInWithEmailAndPassword(email, password)
            .then(() => {
                this.setState({ ...INITIAL_STATE });
                history.push(routes.DASHBOARD);
            })
            .catch(error => {
                this.setState(byPropKey('error', error));
            });

        event.preventDefault();
    }

    doSignInWithGoogle = (event) => {
        const googleProvider = new firebase.auth.GoogleAuthProvider();
        firebase.auth().signInWithPopup(googleProvider)
            .then((result) => {
                console.log(result);
            })
            .catch((err) => {
                console.log(err);
            });
    }

    render() {
        const {
            email,
            password,
            error
        } = this.state;

        const isInvalid = 
        password === '' ||
        email === '';

        return(
           <form >
               <input 
                    value={ email }
                    onChange={ event => this.setState(byPropKey('email', event.target.value))}
                    type='text'
                    placeholder="Email"
               />
               <input 
                    value={ password }
                    onChange={ event => this.setState(byPropKey('password', event.target.value))}
                    type='password'
                    placeholder="Password"
               />
               <button onClick={this.doSignInWithGoogle}>Google Sign In</button>
               <button disabled={ isInvalid } onClick={this.onSubmit}>Sign In</button>
               { error && <p>{error.message}</p> }
           </form> 
        ) 
    };
};

export default withRouter(SignInPage);

export {
    SignInView,
};