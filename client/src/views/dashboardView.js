import React, { Component } from "react";
// import { connect } from 'react-redux';

// import PasswordChangeForm from "../components/UpdatePW";
import DashboardNavigaton from "../components/DashboardNavigation";
import SideBar from "../components/SideBar";

class DashboardView extends Component {
  render() {
    return (
      <div>
          <DashboardNavigaton />
          <div>New Asignment</div>
          <div> + </div>
          <SideBar />
          {/* <PasswordChangeForm /> */}
      </div>
    );
   }
 }
 
 export default DashboardView;