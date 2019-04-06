// Settings page: Add and update account information
import React, { Component } from "react";
import axios from "axios";
import firebase from "firebase";

import UpdateInfoModal from "./UpdateInfoModal";
import { SettingsContainer, Info } from "./SettingsStyling";


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
      <SettingsContainer>
        <h2>Account Information</h2>
        <Info>
          <div style={{padding:"0.5rem 0"}}> {this.state.email}</div>
          <div> {this.state.prefix} {this.state.firstName} {this.state.lastName}</div>
        </Info>

        <UpdateInfoModal />
      </SettingsContainer>
    );
  }
}

export default Settings;
