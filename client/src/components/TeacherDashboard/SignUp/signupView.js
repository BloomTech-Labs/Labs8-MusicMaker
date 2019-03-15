//Sign up page view
import React, { Component } from "react";
import { Link, withRouter } from "react-router-dom";
import axios from 'axios';
import { Button, Form, FormGroup, Input, Label } from "reactstrap";

import { auth } from "../../../firebase";
import * as routes from "../../Routes/routes";

const INITIAL_STATE = {
  email: "",
  passwordOne: "",
  passwordTwo: "",
  error: null
};

const SignUpPage = ({ history }) => (
  <div className="container" style={formContainer}>
    <h1 className="subheader" style={{ margin:"10px 7.5rem 35px", color:"white" }}>Sign Up</h1>
    <SignUpView history={history} />
  </div>
);

const byPropKey = (propertyName, value) => () => ({
  [propertyName]: value
});

const formContainer = {
  width: "35%",
  margin: "0 auto 10px",
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
        console.log(authUser.user.uid);

        const authUserInfo = {
          email: authUser.user.email,
          subscribed: false
        }

        axios
          .post(`${routes.TEACHER_URL}/addNewTeacher/${authUser.user.uid}`, authUserInfo)
          .then(res => {
            console.log(res);
          })
          .catch(err => {
            console.log(err);
          })

        history.push(routes.SETTINGS);
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
      <div style={{ margin: "20px" }}>
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
            style={{ margin:"15px 0", width:"100%", background:"#0284A8", fontWeight:"bold" }}
            disabled={isInvalid}
            type="submit"
          >
            Teacher Sign Up
          </Button>
          {error && <p>{error.message}</p>}
        </Form>
      </div>
    );
  }
}

const SignUpLink = () => (
  <p className="bodyText" style={{ margin:"30px 25%", color:"white"}}>
    Don't have an account? <Link to={routes.SIGN_UP} style={{ color:"white"}}>Sign Up!</Link>
  </p>
);

export default withRouter(SignUpPage);

export { SignUpView, SignUpLink };
