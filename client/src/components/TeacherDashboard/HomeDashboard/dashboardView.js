//Dashboard View: This page is the teacher's home page with "+" to create a new ungraded assignment,
//the teacher's qr code will be visible so students can scan it and be sent a sign up page to be added to the teacher.
import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";
import firebase from 'firebase';
import { Button } from 'reactstrap';

import * as routes from "../../Routes/routes";


class DashboardView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      qrcode: ""
    };
  }

  componentDidMount() {
    firebase.auth().onAuthStateChanged(user => {
      if (user) {
        // User is signed in.
        axios
        .get(`${routes.TEACHER_URL}/teacher/${user.uid}/settings`)
        .then(res => {
          this.setState({
            qrcode: res.data.qrcode
          });
        })
        .catch(err => console.error("DASHBOARDVIEW AXIOS ERROR:", err));
        } else {
        // No user is signed in.
        return;
        }
    });
  }

  render() {
    return (
      <div className="container">
        <div className="d-flex ">
          <h1>Dashboard</h1>
          <Link to="/assignments/create">
            <Button > + </Button>
          </Link>
        </div>
          <a href={this.state.qrcode}>
            <img
              src={this.state.qrcode}
              alt="qr code image"
              height="100"
              width="100"
            />
          </a>
      </div>
    );
  }
}

export default DashboardView;
