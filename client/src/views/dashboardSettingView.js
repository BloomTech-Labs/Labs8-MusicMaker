import React, { Component } from "react";

import Sidebar from "../components/SideBar";

import "../css/index.css";

class DashboardSettingView extends Component {
  render() {
    return (
      <div className="container">
        <div className="flex-container">
          <Sidebar />
          <div className="block-container">
            <h1 className="bodyText">Setting View</h1>
          </div>
        </div>
      </div>
    );
  }
}

export default DashboardSettingView;
