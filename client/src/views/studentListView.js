import React, { Component } from "react";
import { NavLink } from "react-router-dom";

import SideBar from "../components/SideBar";

class StudentListView extends Component {
  state = {
    students: []
  };

  render() {
    return (
      <div className="container">
        <div className="flex-container">
          <SideBar />
          <div className="block-container" id="studentList">
            <h1 className="subheader">Students</h1>
            {this.state.students.map(student => (
              <div key={student.id} className="bodyText">
                <NavLink to={`/studentView/${student.id}`}>
                  <h3>
                    {student.firstName} {student.lastName}:
                  </h3>
                  <h3>{student.instrument}</h3>
                  <h3>{student.level}</h3>
                </NavLink>
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  }
}

export default StudentListView;
