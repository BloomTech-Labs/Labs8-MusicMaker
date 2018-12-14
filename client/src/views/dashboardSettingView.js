import React, { Component } from "react";
import axios from "axios";
import firebase from "firebase";
import {
  Button,
  Card,
  CardBody,
  CardImg,
  CardSubtitle,
  CardText,
  CardTitle,
  Form,
  FormGroup,
  FormTitle,
  Input,
  Label
} from "reactstrap";

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
            console.log(res.data);
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

  handleChange = event => {
    this.setState({
      [event.target.name]: event.target.value
    });
  };

  handleSubmit(event) {
    event.preventDefault();
    alert(
      `Settings updated successfully! Your name is now ${this.state.prefix} ${this.state.firstName} ${this.state.lastName}.`
    );
  }

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
            this.props.history.push(`/settings`); // not sure where exactly this has to be pushed
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
    const { email, prefix, firstName, lastName } = this.state;
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
        </Form>
        <Form onSubmit={e => this.handleSubmit(e)}>
          <FormGroup style={{padding: "20px"}}>
            <h2>Update Your Information</h2>
            <Label style={{paddingTop: "10px"}}>Title</Label>
            <Input
              name="prefix"
              value={prefix}
              onChange={this.handleChange}
              type="text"
              style={{paddingTop: "5px"}}
            />
            <Label style={{paddingTop: "10px"}}>First Name</Label>
            <Input
              name="firstName"
              value={firstName}
              onChange={this.handleChange}
              type="text"
              style={{paddingTop: "5px"}}
            />
            <Label style={{paddingTop: "10px"}}>Last Name</Label>
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
            style={{ margin: "20px" }}
          >
            Submit Changes
          </Button>
        </Form>
      </div>
    );
  }
}

export default Settings;
