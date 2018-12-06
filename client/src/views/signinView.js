import React, { Component } from 'react';
// import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import firebase from 'firebase/app';

import { auth } from '../firebase';
import * as routes from '../constants/routes';
import { SignUpLink } from './signupView';
import ForgotPW from '../components/ForgotPW';

// Reactstrap styling

import { Button, ButtonToolbar, Col, Form, FormGroup, Input, Label, Row } from 'reactstrap';

const SignInPage = ({ history }) =>
    <div className="container" style={formContainer}>
        <h1 className="subheader" font-family="Merriweather">Sign In</h1>
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

const formContainer = { maxWidth: 800, margin: '0 auto 10px' };

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

            event.preventDefault();
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
          <div className = 'signin-form' style={formContainer}>
            <Form>
              <FormGroup>
                <Label>Email</Label>
                 <Input
                      value={ email }
                      onChange={ event => this.setState(byPropKey('email', event.target.value))}
                      type='text'
                 />
              </FormGroup>
              <FormGroup>
                <Label>Password</Label>
                  <Input
                  value={ password }
                  onChange={ event => this.setState(byPropKey('password', event.target.value))}
                  type='password'
                  />
              <ButtonToolbar style={{ paddingTop: "25px", paddingBottom: "20px" }}>
               <Button color="primary" bsSize="small" style={{ marginRight: "15px" }} onClick={this.doSignInWithGoogle}>Google Sign In</Button>
               <Button outline color="primary" bsSize="small" disabled={ isInvalid } onClick={this.onSubmit}>Sign In</Button>
              </ButtonToolbar>
             { error && <p>{error.message}</p> }
             </FormGroup>
            </Form>
          </div>
        )
    };
};

export default withRouter(SignInPage);

export {
    SignInView,
};
