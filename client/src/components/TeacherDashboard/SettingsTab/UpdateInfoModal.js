//Update account info modal view
import React from 'react';
import axios from "axios";
import firebase from "firebase";
import { Button, Modal, ModalHeader, ModalBody, Form, FormGroup, Input, Label } from 'reactstrap';


class ModalExample extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      modal: false
    };

    this.toggle = this.toggle.bind(this);
  }

  toggle() {
    this.setState(prevState => ({
      modal: !prevState.modal
    }));
  }

  handleChange = event => {
    this.setState({
      [event.target.name]: event.target.value
    });
  };

  // handleSubmit(event) {
  //   // event.preventDefault();
  //   alert(
  //     `Settings updated successfully! Your name is now ${this.state.prefix} ${this.state.firstName} ${this.state.lastName}.`
  //   );
  // }

  updateName = event => {
    firebase.auth().onAuthStateChanged(user => {
      if (user) {
        // User is signed in.
        const { prefix, firstName, lastName } = this.state;

        axios
          .put(
            `https://musicmaker-4b2e8.firebaseapp.com/teacher/${user.uid}/settingsEdit`,
            { prefix, firstName, lastName }
          )
          .then(res => {
            // console.log('update***', res)
            this.props.history.push(`/settings`);
          })
          .catch(err =>
            console.error(
              "Sorry, an error was encountered while updating your settings.",
              err
            )
          );
      } else {
        // No user is signed in.
        return;
      }
    });
  };

  render() {
    const { prefix, firstName, lastName } = this.state;

    return (
      <div>
        <Button style={{background:"none", border:"none" /*, margin:"0 30%"*/ }}  onClick={this.toggle}>Add and update your info HERE!</Button>
        <Modal isOpen={this.state.modal} toggle={this.toggle} className={this.props.className}>
          <ModalHeader toggle={this.toggle} style={{ color:"#02547D", fontWeight:"bold" }}>Update Your Information</ModalHeader>
          <ModalBody>
          <Form /*onSubmit={e => this.handleSubmit(e)}*/>
            <FormGroup>
              <Label style={{paddingTop: "10px", color:"#02547D", fontWeight:"bold"}}>Title</Label>
              <Input
                name="prefix"
                value={prefix}
                onChange={this.handleChange}
                type="text"
                style={{paddingTop: "5px"}}
              />
              <Label style={{paddingTop: "10px", color:"#02547D", fontWeight:"bold"}}>First Name</Label>
              <Input
                name="firstName"
                value={firstName}
                onChange={this.handleChange}
                type="text"
                style={{paddingTop: "5px"}}
              />
              <Label style={{paddingTop: "10px", color:"#02547D", fontWeight:"bold"}}>Last Name</Label>
              <Input
                name="lastName"
                value={lastName}
                onChange={this.handleChange}
                type="text"
                style={{paddingTop: "5px"}}
              />
              </FormGroup>
              <Button
                type="submit"
                onClick={this.updateName}
                style={{ margin:"-5px 0 10px 0.5%", width:"100%", background:"#02BEC4" }}
              >
                Submit Changes
              </Button>
          </Form>
          </ModalBody>
        </Modal>
      </div>
    );
  }
}

export default ModalExample;