import React, { Component } from "react";
// import { connect } from 'react-redux';

import PasswordChangeForm from "../components/UpdatePW";

class DashboardView extends Component {
  render() {
    return (
      <div>
        <p>Dashboard Page</p>
        <div>
          <PasswordChangeForm />
        </div>
      </div>
    );
  }
}

export default DashboardView;
