//Sign in page view
import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import firebase from "firebase/app";
import { Button, ButtonToolbar, Form, FormGroup, Input, Label } from "reactstrap";

import { auth } from "../../firebase";
import * as routes from "../Routes/routes";
import { SignUpLink } from "../SignUp/signupView";
import ForgotPWModal from "../SignIn/ForgotPWModal"


const SignInPage = ({ history }) => (
  <div className="container" style={formContainer}>
    <h1 className="subheader" style={{ margin:"100px 35% 35px", color:"white" }}>
      Log In
    </h1>
    <SignInView history={history} />
    <ForgotPWModal />
    <SignUpLink />
  </div>
);

const byPropKey = (propertyName, value) => () => ({
  [propertyName]: value
});

const INITIAL_STATE = {
  email: "",
  password: "",
  error: null
};

const formContainer = {
  width: "25%",
  margin: "0 auto 10px",
};

class SignInView extends Component {
  constructor(props) {
    super(props);

    this.state = { ...INITIAL_STATE };
  }

  onSubmit = event => {
    const { email, password } = this.state;

    const { history } = this.props;

    auth
      .doSignInWithEmailAndPassword(email, password)
      .then(() => {
        this.setState({ ...INITIAL_STATE });
        history.push(routes.DASHBOARD);
      })
      .catch(error => {
        this.setState({ ...INITIAL_STATE });
        this.setState(byPropKey("error", error));
      });

    event.preventDefault();
  };

  doSignInWithGoogle = event => {
    console.log(this.props);
    const { history } = this.props;
    console.log(this.props);

    const googleProvider = new firebase.auth.GoogleAuthProvider();
    firebase
      .auth()
      .signInWithPopup(googleProvider)
      .then(() => {
        this.setState({ ...INITIAL_STATE });
        history.push(routes.DASHBOARD);
      })
      .catch(error => {
        this.setState({ ...INITIAL_STATE });
        this.setState(byPropKey("error", error));
      });

    event.preventDefault();
  };

  render() {
    const { email, password, error } = this.state;

    const isInvalid = password === "" || email === "";

    return (
      <div className="signin-form" style={{ margin: "20px" }}>
        <Form>
          <FormGroup>
            <Label style={{ color:"white", fontWeight:"bold" }}>Email</Label>
            <Input
              value={email}
              onChange={event =>
                this.setState(byPropKey("email", event.target.value))
              }
              type="text"
            />
          </FormGroup>
          <FormGroup>
            <Label style={{ color:"white", fontWeight:"bold" }}>Password</Label>
            <Input
              value={password}
              onChange={event =>
                this.setState(byPropKey("password", event.target.value))
              }
              type="password"
            />
            <ButtonToolbar style={{ margin:"25px 0" }}>
              <Button
                color="primary"
                bsSize="small"
                style={{ width:"47.5%", marginRight:"5%", background:"#02547D"}}
                onClick={this.doSignInWithGoogle}
              >
                Google Log In
              </Button>
              <Button
                outline
                color="primary"
                bsSize="small"
                disabled={isInvalid}
                style={{ width:"47.5%", color:"white", background:"#02547D" }}
                onClick={this.onSubmit}
              >
                Email Log In
              </Button>
            </ButtonToolbar>
            {error && <p>{error.message}</p>}
          </FormGroup>
        </Form>
      </div>
    );
  }
}

export default withRouter(SignInPage);

export { SignInView };
