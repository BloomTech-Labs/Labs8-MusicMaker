//Forgot password info that show's up in ForgotPWModal.js
import React, { Component } from 'react';
import { Button, Form, FormGroup, Input, Label } from 'reactstrap';

import { auth } from '../../firebase';


const PasswordForgetPage = () =>
  <div className="container" style={{ marginLeft: "-17px" }}>
    <PasswordForgetForm />
  </div>

const byPropKey = (propertyName, value) => () => ({
  [propertyName]: value,
});

const INITIAL_STATE = {
  email: '',
  error: null,
};

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
            <Label style={{ color:"#02547D" }}>Email</Label>
              <Input
                value={this.state.email}
                onChange={event => this.setState(byPropKey('email', event.target.value))}
                type="text"
                style={{ marginBottom: "30px", width:"108%" }}
              />
            <Button color="info" style={{ marginBottom: "30px", width:"108%", background:"#02BEC4" }} disabled={isInvalid} type="submit">
              Reset My Password
            </Button>
            { error && <p>{error.message}</p> }
          </FormGroup>
        </Form>
      </div>
    );
  }
}


export default PasswordForgetPage;

export {
  PasswordForgetForm
};
