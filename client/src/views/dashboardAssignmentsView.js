import React, { Component } from "react";
import axios from "axios";

import Sidebar from "../components/SideBar";
import "../css/index.css";

class DashboardAssignmentsView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      assignmentName: "",
      instructions: "",
      instrument: "",
      level: "",
      piece: "",
      sheetMusic:""
    };
  };

    componentDidMount() {
        axios
            .get('https://musicmaker-4b2e8.firebaseapp.com/teacher/AHnU7PuWMohJWEWZJbvd/assignments')
            .then(res => {
                console.log('*******************', Object.values(res.data), res.data)
                this.setState({
                    assignmentName: Object.values(res.data)[0][0],
                    instructions: Object.values(res.data)[0][1],
                    instrument: Object.values(res.data)[0][2],
                    level: Object.values(res.data),
                    piece: Object.values(res.data),
                    sheetMusic: Object.values(res.data)
                })
            })
            .catch(err => console.error('ASSIGNMENTS AXIOS ERROR:', err));
    }
  render() {
    return (
      <div className="container">
        <div className="flex-container">
          <Sidebar />
          <div className="block-container" id="assignments">
            <h1 className="subheader">Assignments View</h1>
            <p className="bodyText">Assignment Name: {this.state.assignmentName}</p>
            <p className="bodyText">Piece: {this.state.piece}</p>
            <p className="bodyText">Instrument: {this.state.instrument}</p>
            <p className="bodyText">Level: {this.state.level}</p>
            <p className="bodyText">Instructions: {this.state.instructions}</p>
          </div>
        </div>
      </div>
    );
  }
}

export default DashboardAssignmentsView;
