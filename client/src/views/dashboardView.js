import React, { Component } from "react";
// import { connect } from 'react-redux';

import PasswordChangeForm from "../components/UpdatePW";
import TeacherDashboardView from "./teacherDashboardView";

class DashboardView extends Component {
  render() {
    return (
      <div>
        <p>Dashboard Page</p>
        <div>
          <TeacherDashboardView />
          <PasswordChangeForm />
        </div>
      </div>
    );
  }
}

export default DashboardView;
