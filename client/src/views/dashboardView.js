//Dashboard View: This page is the teacher's home page with "+" to create a new ungraded assignment,
//the teacher's qr code will be visible so students can scan it and be sent a sign up page to be added to the teacher.

import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";

const formContainer = { maxWidth: 800, margin: '0 auto 10px', border: "3px solid #A9E8DC" };

class DashboardView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      qrcode: ""
    };
  }

  componentDidMount() {
    const teacherId = 'pwUGQC7SHBiPKPdnOq2c' //this.props.match.params.id;

    axios
      .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${teacherId}/settings`)
      .then(res => {
        this.setState({
          qrcode: res.data.qrcode
        });
      })
      .catch(err => console.error("DASHBOARDVIEW AXIOS ERROR:", err));
  }

  render() {
    return (
      <div className="container" style={formContainer}>
        <div className="d-flex ">
          <h1 style={{marginTop: "10px", marginBottom: "10px"}}>Dashboard</h1>
          <Link to="/assignments/create">
            <h1 style={{position: "relative", left: "30px", top: "8px"}}> + </h1>
          </Link>
        </div>
        <div>
          <h3 style={{paddingTop: "20px", paddingBottom: "20px"}}>QR Code</h3>
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
