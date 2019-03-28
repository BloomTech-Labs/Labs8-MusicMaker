// Settings page: Add and update account information
import React, { Component } from "react";
import axios from "axios";
import firebase from "firebase";
import { CardSubtitle, CardText, CardTitle, Form } from "reactstrap";

import UpdateInfoModal from "./UpdateInfoModal";


const formContainer = {
  maxWidth: 800,
  margin: "0 auto 10px",
  border: "3px solid #A9E8DC"
};

class Settings extends Component {
  constructor(props) {
    super(props);
    this.state = {
      email: "",
      name: {
        prefix: "",
        firstName: "",
        lastName: ""
      }
    };
  }

  componentDidMount() {
    firebase.auth().onAuthStateChanged(user => {
      if (user) {
        // User is signed in.
        axios
          .get(
            `https://musicmaker-4b2e8.firebaseapp.com/teacher/${user.uid}/settings`
          ) //match params.id when this becomes fully dynamic
          .then(res => {
            // console.log("here****" ,res);
            this.setState({
              email: res.data.email
            });
            this.setState({
              prefix: res.data.name.prefix,
              firstName: res.data.name.firstName,
              lastName: res.data.name.lastName
            });
          })
          .catch(err => console.error("Sorry, an error was encountered.", err));
      } else {
        // No user is signed in.
        return;
      }
    });
  }

  render() {

    return (
      <div className="container" style={formContainer}>
        <Form style={{ padding: "20px" }}>
          <CardTitle style={{ margin: "10px" }}>Your Information</CardTitle>
          <CardSubtitle style={{ margin: "10px" }}>
            Email: {this.state.email}
          </CardSubtitle>
          <CardText style={{ margin: "10px" }}>
            Title: {this.state.prefix}
          </CardText>
          <CardText style={{ margin: "10px" }}>
            First Name: {this.state.firstName}
          </CardText>
          <CardText style={{ margin: "10px" }}>
            Last Name: {this.state.lastName}
          </CardText>
          <UpdateInfoModal />
        </Form>
      </div>
    );
  }
}

export default Settings;
