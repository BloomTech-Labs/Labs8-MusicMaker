import React, { Component } from "react";

import Sidebar from "../components/SideBar";

import "../css/index.css";

class CreateAssignmentView extends Component {
  render() {
    return (
      <div className="container">
        <div className="flex-container">
          <Sidebar />
          <div className="block-container">
            <form type="submit">
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
                <input
                  className="bodyText"
                  type="text"
                  name="instrument"
                  placeholder="Instrument"
                />
                <input
                  className="bodyText"
                  type="text"
                  name="level"
                  placeholder="Level"
                />
              </div>
              <div>
                <label className="bodyText">Instructions</label>
                <input className="bodyText" type="text" name="instructions" />
              </div>
              <button>Submit</button>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

export default CreateAssignmentView;
