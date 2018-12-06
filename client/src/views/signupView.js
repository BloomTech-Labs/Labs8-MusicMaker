import React, { Component } from "react";
import { Link, withRouter } from "react-router-dom";

import { auth } from '../firebase';

import * as routes from "../constants/routes";

const INITIAL_STATE = {
//   firstName: "",
//   lastName: "",
  email: "",
  passwordOne: "",
  passwordTwo: "",
  error: null
};

const SignUpPage = ({ history }) => (
  <div className="container">
    <h1 className="subheader">Sign Up</h1>
    <SignUpView history={ history }/>
  </div>
);

const byPropKey = (propertyName, value) => () => ({
  [propertyName]: value
});

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
        <form className="bodyText" onSubmit={this.onSubmit}>
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
            <input
                value={ email }
                onChange={ event => this.setState(byPropKey('email', event.target.value)) }
                type ="text"
                placeholder="Email"
            />
            <input
                value={ passwordOne }
                onChange={ event => this.setState(byPropKey('passwordOne', event.target.value)) }
                type ="password"
                placeholder="Password"
            />
            <input
                value={ passwordTwo }
                onChange={ event => this.setState(byPropKey('passwordTwo', event.target.value)) }
                type ="password"
                placeholder="Confirm Password"
            />
            <button disabled={ isInvalid } type="submit">Sign Up</button>

            { error && <p>{ error.message }</p>}
        </form>
    )
  }
}

const SignUpLink = () => (
  <p className="bodyText">
    Don't have an account? <Link to={routes.SIGN_UP}>Sign Up</Link>
  </p>
);

export default withRouter(SignUpPage);

export { SignUpView, SignUpLink };
