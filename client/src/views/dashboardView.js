//Dashboard View: This page is the teacher's home page with "+" to create a new ungraded assignment,
//the teacher's qr code will be visible so students can scan it and be sent a sign up page to be added to the teacher.

import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";
import firebase from 'firebase';
import { Button } from 'reactstrap';

const formContainer = { maxWidth: 800, margin: '0 auto 10px', border: "3px solid #A9E8DC" };

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
        .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${user.uid}/settings`)
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
      <div className="container" style={formContainer}>
        <div className="d-flex ">
          <h1 style={{marginTop: "10px", marginBottom: "10px"}}>Dashboard</h1>
          <Link to="/assignments/create">
            <Button style={{position: "relative", left: "30px", top: "20px"}}> + </Button>
          </Link>
        </div>
        <div>
          <h3 style={{padding: "5px 5px 15px 5px"}}>QR Code:</h3>
          <a href={this.state.qrcode}>
            <img
              src={this.state.qrcode}
              alt="qr code image"
              height="100"
              width="100"
            />
          </a>
        </div>
      </div>
    );
  }
}

export default DashboardView;
