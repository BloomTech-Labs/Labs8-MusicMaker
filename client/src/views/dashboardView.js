import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import axios from "axios";

class DashboardView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      qrcode: ''
    };
  };

  componentDidMount() {
    axios
        .get('https://musicmaker-4b2e8.firebaseapp.com/teacher/TrYgvfzQJplN9khJhiJg/settings')
        .then(res => {
            console.log('*******************', res.data);
            this.setState({
                qrcode: res.data.qrcode,
            })
        })
        .catch(err => console.error('DASHBOARDVIEW AXIOS ERROR:', err));
}

  render() {
    return (
      <div className="container">
        <div className="flex-container">
          <div className="block-container">
            <div className="subheader">New Assignment</div>
            <NavLink to='/assignments/create' className="bodyText"> + </NavLink>
            <p className="bodyText"><a href={this.state.qrcode}><img src={this.state.qrcode} alt="qr code image" height="100" width="100"/></a></p>
          </div>
        </div>
      </div>
    );
  }
}

export default DashboardView;
