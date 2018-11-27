import React, { Component } from "react";
import { NavLink } from "react-router-dom";

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
            <NavLink to='/assignments/create' className="bodyText"> + </NavLink>
          </div>
        </div>
      </div>
    );
  }
}

export default DashboardView;
