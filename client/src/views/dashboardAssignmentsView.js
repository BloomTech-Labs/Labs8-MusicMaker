import React, { Component } from "react";
import axios from "axios";
import { Link } from "react-router-dom";

class DashboardAssignmentsView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      assignmentName: "",
      instructions: "",
      instrument: "",
      level: "",
      piece: "",
      sheetMusic: ""
    };
  }

  componentDidMount() {
    axios
      .get(
        "https://musicmaker-4b2e8.firebaseapp.com/teacher/pwUGQC7SHBiPKPdnOq2c/assignment/UsvQvEgdUzhpN3iWlcDg"
      )
      .then(res => {
        this.setState({
          assignmentName: res.data.assignmentName,
          instructions: res.data.instructions,
          instrument: res.data.instrument,
          level: res.data.level,
          piece: res.data.piece,
          sheetMusic: res.data.sheetMusic
        });
      })
      .catch(err => console.error("ASSIGNMENTS AXIOS ERROR:", err));
  }
  render() {
    return (
      <div className="container">
        <div className="d-flex">
          <h1>Assignments View</h1>
          <Link to="/assignments/create">
            <h1> + </h1>
          </Link>
        </div>

        <div className="d-block">
          <h5>Test: This is an ungraded assignment for a specific teacher</h5>
          <p>Assignment Name: {this.state.assignmentName}</p>
          <p>Piece: {this.state.piece}</p>
          <p>Instrument: {this.state.instrument}</p>
          <p>Level: {this.state.level}</p>
          <p>
            Sheet Music:{" "}
            <a href={this.state.sheetMusic}>
              <img
                src={this.state.sheetMusic}
                alt="pdf image"
                height="42"
                width="42"
              />
            </a>
          </p>
          <p>Instructions:{this.state.instructions}</p>
        </div>
      </div>
    );
  }
}

export default DashboardAssignmentsView;
