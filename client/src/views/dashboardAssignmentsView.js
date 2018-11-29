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
            .get('https://musicmaker-4b2e8.firebaseapp.com/teacher/AHnU7PuWMohJWEWZJbvd/assignment/xuKzpfxGQtaYqOYvoNZG')
            .then(res => {
                console.log('*******************', res.data);
                this.setState({
                    assignmentName: res.data.assignmentName,
                    instructions: res.data.instructions,
                    instrument: res.data.instrument,
                    level: res.data.level,
                    piece: res.data.piece,
                    sheetMusic: res.data.sheetMusic
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
            <p className="bodyText">Sheet Music: <a href={this.state.sheetMusic}><img src={this.state.sheetMusic} alt="pdf image" height="42" width="42"/></a></p>
            <p className="bodyText">Instructions:{this.state.instructions}</p>
          </div>
        </div>
      </div>
    );
  }
}

export default DashboardAssignmentsView;
