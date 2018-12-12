import React, { Component } from "react";
import axios from "axios";

import { Button, Card, CardBody, CardImg, CardSubtitle, CardText, CardTitle } from 'reactstrap';

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
  };

    componentDidMount() {
        axios
            .get('https://musicmaker-4b2e8.firebaseapp.com/teacher/AHnU7PuWMohJWEWZJbvd/settings')
            .then(res => {
                console.log('*******************', res.data)
                this.setState({
                    email: res.data.email,
                    prefix: res.data.name.prefix,
                    firstName: res.data.name.firstName,
                    lastName: res.data.name.lastName
                })
            })
            .catch(err => console.error('SETTINGS AXIOS ERROR:', err));
    }

  render() {
    return (
      <div className="container">
        <div className="flex-container">
          <div className="block-container" id="setting">
            <h1 className="subheader">
              Testing that the Front End is Connecting to the Back End
            </h1>
            <p className="bodyText">
              This is immutable, for now it only directs to the settings of a
              specific teacher
            </p>
            <p className="bodyText">Email: {this.state.email}</p>
            <p className="bodyText">Prefix: {this.state.prefix}</p>
            <p className="bodyText">First Name: {this.state.firstName}</p>
            <p className="bodyText">Last Name: {this.state.lastName}</p>
          </div>
        </div>
      </div>
    );
  }
}

export default Settings;
