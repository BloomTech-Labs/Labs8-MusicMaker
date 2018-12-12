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
      axios
          .get('https://musicmaker-4b2e8.firebaseapp.com/teacher/pwUGQC7SHBiPKPdnOq2c/settings') //match params.id when this becomes fully dynamic
          .then(res => {
              console.log(res.data)
              this.setState({
                  email: res.data.email,
                  prefix: res.data.name.prefix,
                  firstName: res.data.name.firstName,
                  lastName: res.data.name.lastName
              })
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
