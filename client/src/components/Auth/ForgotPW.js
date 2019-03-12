import React, { Component } from 'react';
import { Link } from 'react-router-dom';

import { auth } from '../../firebase';
import * as routes from '../Routes/routes';

import { Button, ButtonToolbar, Col, Form, FormGroup, Input, Label, Row } from 'reactstrap';

const PasswordForgetPage = () =>
  <div className="container" style={{ marginLeft: "-17px" }}>
    <h1 className="bodyText" style={{ margin: "20px" }}>Reset Password?</h1>
    <PasswordForgetForm />
  </div>

const byPropKey = (propertyName, value) => () => ({
  [propertyName]: value,
});

const INITIAL_STATE = {
  email: '',
  error: null,
};

const formContainer = { maxWidth: 800, margin: '0 auto 10px' };

class PasswordForgetForm extends Component {
  constructor(props) {
    super(props);

    this.state = { ...INITIAL_STATE };
  }

  onSubmit = (event) => {
    const { email } = this.state;

    auth.doPasswordReset(email)
      .then(() => {
        this.setState({ ...INITIAL_STATE });
      })
      .catch(error => {
        this.setState(byPropKey('error', error));
      });

    event.preventDefault();
  }

  render() {
    const {
      email,
      error,
    } = this.state;

    const isInvalid = email === '';

    return (
      <div className = 'signin-form' style={{ margin: "20px" }}>
        <Form>
          <FormGroup onSubmit={this.onSubmit}>
            <Label>Email</Label>
              <Input
                value={this.state.email}
                onChange={event => this.setState(byPropKey('email', event.target.value))}
                type="text"
                style={{ marginBottom: "30px" }}
              />
            <Button color="info" style = {{ marginBottom: "30px" }} disabled={isInvalid} type="submit">
              Reset My Password
            </Button>

            { error && <p>{error.message}</p> }
          </FormGroup>
        </Form>
      </div>
    );
  }
}

const PasswordForgetLink = () =>
  <p>
    <Link to={routes.DASHBOARD}>Forgot Password?</Link>
  </p>

export default PasswordForgetPage;

export {
  PasswordForgetForm,
  PasswordForgetLink,
};
