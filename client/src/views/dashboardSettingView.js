import React, { Component } from "react";
import axios from "axios";

import { Button, Card, CardBody, CardImg, CardSubtitle, CardText, CardTitle, Label } from 'reactstrap';

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
      const teacherId = 'pwUGQC7SHBiPKPdnOq2c'; // change this (with params matching) to make this more dynamic, currently one teacher for testing

        axios
            .get('https://musicmaker-4b2e8.firebaseapp.com/teacher/${teacherId}/settings')
            .then(res => {
                this.setState({settings: res.data})
            })
            .catch(err => console.error('Sorry, an error was encountered.', err));
    }

  render() {
    return (
      <div>
        <Label>Your Settings</Label>
          {this.state.settings.map(teacher => (
            <Card key = {teacher.id}>
              <CardTitle>{teacher.email}</CardTitle>
            </Card>
          ))}
      </div>
    );
  }
}

export default Settings;
