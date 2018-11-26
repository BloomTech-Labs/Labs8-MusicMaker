import React, { Component } from "react";

import DashboardNavigation from "../components/DashboardNavigation";
import SideBar from "../components/SideBar";

import "../css/index.css";

class DashboardView extends Component {
  render() {
    return (
      <div className="container">
        <div className="flex-container">
          <SideBar />
          <div className="block-container" id="newAssignment">
            <div className="subheader">New Assignment</div>
            <button className="bodyText"> + </button>
          </div>
        </div>
      </div>
    );
  }
}

export default DashboardView;
