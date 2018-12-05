import React, { Component } from "react";

import Sidebar from "../components/SideBar";

class CreateAssignmentView extends Component {
  render() {
    return (
      <div className="container">
        <div className="flex-container">
          <Sidebar />
          <div className="block-container">
            <form className="assignmentForm" type="submit">
              <div>
                <input
                  className="subheader"
                  type="text"
                  name="assignment-name"
                  placeholder="Assignment Name"
                />
              </div>
              <div>
                <input
                  className="bodyText"
                  type="text"
                  name="piece"
                  placeholder="Piece"
                />
                <select className="bodyText" name="instrument">
                  <option value="guitar">Guitar</option>
                  <option value="piano">Piano</option>
                  <option value="trumpet">Trumpet</option>
                  <option value="violin">Violin</option>
                  <option value="saxophone">Saxophone</option>
                  <option value="drum">Drum</option>
                </select>
                <select className="bodyText" name="level">
                  <option value="beginner">Beginner</option>
                  <option value="intermediate">Intermediate</option>
                  <option value="advanced">Advanced</option>
                </select>
              </div>
              <div>
                <label className="bodyText">Instructions</label>
                <input className="bodyText" type="text" name="instructions" />
              </div>
              <button className="submit">Submit</button>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

export default CreateAssignmentView;
