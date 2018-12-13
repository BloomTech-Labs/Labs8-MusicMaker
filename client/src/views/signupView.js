import React, { Component } from "react";
import { Link, withRouter } from "react-router-dom";
import axios from 'axios';

import { auth } from "../firebase";

import * as routes from "../constants/routes";

// Reactstrap styling
import { Button, Form, FormGroup, Input, Label } from "reactstrap";

const INITIAL_STATE = {
  email: "",
  passwordOne: "",
  passwordTwo: "",
  error: null
};

const SignUpPage = ({ history }) => (
  <div className="container" style={formContainer}>
    <h1 className="subheader" style={{ margin: "20px" }}>
      Sign Up
    </h1>
    <SignUpView history={history} />
  </div>
);

const byPropKey = (propertyName, value) => () => ({
  [propertyName]: value
});

const formContainer = {
  maxWidth: 800,
  margin: "0 auto 10px",
  border: "3px solid #A9E8DC"
};

class SignUpView extends Component {
  constructor(props) {
    super(props);

    this.state = { ...INITIAL_STATE };
  }

  onSubmit = event => {
    const { email, passwordOne } = this.state;

    const { history } = this.props;

    auth
      .doCreateUserWithEmailAndPassword(email, passwordOne)
      .then(authUser => {
        this.setState({ ...INITIAL_STATE });

        // const nameArr = authUser.user.displayName.split(' ');

        let authUserInfo = new FormData();

        authUserInfo.append('email', authUser.user.email);
        authUserInfo.append('subscribed', false);

        // const authUserInfo = {
        //   email: authUser.user.email,
          // name: {
          //   firstName: nameArr[0],
          //   lastName: nameArr[1]
          // },
        //   subscribed: false
        // }

        axios
          .post('https://musicmaker-4b2e8.firebaseapp.com/addNewTeacher', authUserInfo)
          .then(res => {
            console.log(res);
          })
          .catch(err => {
            console.log(err);
          })

        history.push(routes.DASHBOARD);
      })
      .catch(error => {
        this.setState(byPropKey("error", error));
      });

    event.preventDefault();
  };

  render() {
    const { email, passwordOne, passwordTwo, error } = this.state;

    const isInvalid =
      passwordOne !== passwordTwo ||
      passwordOne === "" ||
      passwordTwo === "" ||
      email === "";

    return (
      <div className="signup-form" style={{ margin: "20px" }}>
        <Form onSubmit={this.onSubmit}>
          <FormGroup>
            <Label>Email</Label>
            <Input
              value={email}
              onChange={event =>
                this.setState(byPropKey("email", event.target.value))
              }
              type="text"
              style={{ marginTop: "5px", marginBottom: "15px" }}
            />
          </FormGroup>
          <FormGroup>
            <Label>Password</Label>
            <Input
              value={passwordOne}
              onChange={event =>
                this.setState(byPropKey("passwordOne", event.target.value))
              }
              type="password"
              style={{ marginTop: "5px", marginBottom: "15px" }}
            />
          </FormGroup>
          <FormGroup>
            <Label>Confirm Password</Label>
            <Input
              value={passwordTwo}
              onChange={event =>
                this.setState(byPropKey("passwordTwo", event.target.value))
              }
              type="password"
              style={{ marginTop: "5px", marginBottom: "15px" }}
            />
          </FormGroup>
          <Button
            color="primary"
            bsSize="large"
            style={{ marginTop: "15px", marginBottom: "15px" }}
            disabled={isInvalid}
            type="submit"
          >
            Sign Up
          </Button>
          {error && <p>{error.message}</p>}
        </Form>
      </div>
    );
  }
}

const SignUpLink = () => (
  <p className="bodyText" style={{ margin: "20px" }}>
    Don't have an account? <Link to={routes.SIGN_UP}>Sign Up!</Link>
  </p>
);

export default withRouter(SignUpPage);

export { SignUpView, SignUpLink };
