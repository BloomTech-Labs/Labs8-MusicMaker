import React, { Component } from "react";
// import { connect } from 'react-redux';

// import PasswordChangeForm from "../components/UpdatePW";
import TeacherDashboardView from "./teacherDashboardView";

class DashboardView extends Component {
  render() {
    return (
      <div>
        <div>
          <TeacherDashboardView />
          <div>New Asignment</div>

          {/* <PasswordChangeForm /> */}
        </div>
      </div>
    );
  }
}

export default DashboardView;
