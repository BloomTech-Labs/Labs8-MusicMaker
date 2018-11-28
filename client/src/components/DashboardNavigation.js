import React, { Component } from "react";
import { NavLink } from "react-router-dom";
import SignOutButton from "./SignOutButton";

import '../css/index.css';

class DashboardNavigation extends Component {
  render() {
    return (
      <div className="dashboard-nav">
        <nav className="left-nav">
          <NavLink exact to="/">
            Home
          </NavLink>
          &nbsp; > &nbsp;
          <NavLink to="/assignments">Assignments</NavLink>
        </nav>
        <nav className="right-nav">
          <SignOutButton />
        </nav>
      </div>
    );
  }
}
export default DashboardNavigation;
