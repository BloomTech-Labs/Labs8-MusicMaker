import React, { Component } from "react";

import Sidebar from "../components/SideBar";

import "../css/index.css";

class DashboardAssignmentsView extends Component {
  render() {
    return (
      <div className="container">
        <div className="flex-container">
          <Sidebar />
          <div className="block-container" id="assignments">
            <h1 className="subheader">Assignments View</h1>
          </div>
        </div>
      </div>
    );
  }
}

export default DashboardAssignmentsView;
