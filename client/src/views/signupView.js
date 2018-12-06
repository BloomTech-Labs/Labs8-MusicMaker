import React, { Component } from "react";
import { Link, withRouter } from "react-router-dom";

import { auth } from '../firebase';

import * as routes from "../constants/routes";

// Reactstrap styling

import { Button, ButtonToolbar, Col, Form, FormGroup, Input, Label, Row } from 'reactstrap';

const INITIAL_STATE = {
//   firstName: "",
//   lastName: "",
  email: "",
  passwordOne: "",
  passwordTwo: "",
  error: null
};

const SignUpPage = ({ history }) => (
  <div className="container" style={formContainer}>
    <h1 className="subheader" style={{margin: "20px" }}>Sign Up</h1>
    <SignUpView history={ history }/>
  </div>
);

const byPropKey = (propertyName, value) => () => ({
  [propertyName]: value
});

const formContainer = { maxWidth: 800, margin: '0 auto 10px', border: "3px solid #A9E8DC" };

class SignUpView extends Component {
  constructor(props) {
    super(props);

    this.state = { ...INITIAL_STATE };
  }

  onSubmit = event => {
      const {
        //   firstName,
        //   lastName,
          email,
          passwordOne
      } = this.state;

      const {
          history,
      } = this.props;

      auth.doCreateUserWithEmailAndPassword(email, passwordOne)
        .then(authUser => {
            this.setState({ ...INITIAL_STATE });
            history.push(routes.LANDING);
        })
        .catch(error => {
            this.setState(byPropKey('error', error));
        });

        event.preventDefault();
  };

  render() {
    const {
        // firstName,
        // lastName,
        email,
        passwordOne,
        passwordTwo,
        error
    } = this.state;

    const isInvalid =
    passwordOne !== passwordTwo ||
    passwordOne === '' ||
    passwordTwo === '' ||
    email === '';
    // firstName === '' ||
    // lastName === ''

    return (
        <div className = 'signup-form' style={{ margin: "20px" }}>
          <Form onSubmit={this.onSubmit}>
              {/* <input
                  value={ firstName }
                  onChange={ event => this.setState(byPropKey('firstName', event.target.value)) }
                  type ="text"
                  placeholder="First Name"
              />
              <input
                  value={ lastName }
                  onChange={ event => this.setState(byPropKey('lastName', event.target.value)) }
                  type ="text"
                  placeholder="Last Name"
              /> */}
              <FormGroup>
                <Label>Email</Label>
                  <Input
                      value={ email }
                      onChange={ event => this.setState(byPropKey('email', event.target.value)) }
                      type ="text"
                      style={{ marginTop: "5px", marginBottom: "15px" }}
                  />
              </FormGroup>
              <FormGroup>
                <Label>Password</Label>
                  <Input
                      value={ passwordOne }
                      onChange={ event => this.setState(byPropKey('passwordOne', event.target.value)) }
                      type ="password"
                      style={{ marginTop: "5px", marginBottom: "15px" }}
                  />
              </FormGroup>
              <FormGroup>
                <Label>Confirm Password</Label>
                  <Input
                      value={ passwordTwo }
                      onChange={ event => this.setState(byPropKey('passwordTwo', event.target.value)) }
                      type ="password"
                      style={{ marginTop: "5px", marginBottom: "15px" }}
                  />
              </FormGroup>
              <Button color="primary" bsSize="large" style={{ marginTop: "15px", marginBottom: "15px" }} disabled={ isInvalid } type="submit">Sign Up</Button>
              { error && <p>{ error.message }</p>}
          </Form>
        </div>
    )
  }
}

const SignUpLink = () => (
  <p className="bodyText" style={{ margin: "20px" }}>
    Don't have an account? <Link to={routes.SIGN_UP}>Sign Up!</Link>
  </p>
);

export default withRouter(SignUpPage);

export { SignUpView, SignUpLink };
