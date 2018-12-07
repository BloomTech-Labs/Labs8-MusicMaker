import React, { Component } from "react";
import { Link } from "react-router-dom";
import axios from "axios";

class DashboardView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      qrcode: ""
    };
  }

  componentDidMount() {
    axios
      .get(
        "https://musicmaker-4b2e8.firebaseapp.com/teacher/TrYgvfzQJplN9khJhiJg/settings"
      )
      .then(res => {
        this.setState({
          qrcode: res.data.qrcode
        });
      })
      .catch(err => console.error("DASHBOARDVIEW AXIOS ERROR:", err));
  }

  render() {
    return (
      <div className="container">
        <div className="d-flex ">
          <h1>Dashboard</h1>
          <Link to="/assignments/create">
            <h1> + </h1>
          </Link>
        </div>
        <div>
          <h3>QR Code</h3>
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
