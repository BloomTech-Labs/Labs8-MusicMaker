import React, { Component } from 'react';
import axios from 'axios';
import SideBar from '../components/SideBar';
import '../css/index.css';

// we can figure out exactly how to navigate to this

class GradeAssignmentView extends Component {

  constructor(props) {
    super(props);
    this.state = {
      title: '',
      instrument: '',
      difficulty: ''

      // add pdf and video when we have these endpoints finalized
    }
  };

  // componentDidMount() {
  //   axios
  //     .get('https://musicmaker-4b2e8.firebaseapp.com/studentendpointhere)
  //     .then(res => {
  //       console.log(res.data)
  //       this.setState({
  //         title: res.data.title,
  //         instrument: res.data.instrument,
  //         difficulty: res.data.difficulty
  //       })
  //     })
  //     .catch(err => console.error('An error was encountered.', err));
  // } // this will not work until we have the student endpoints complete

  render() {
    return (
      <div className="container">
        <div className="flex-container">
          <SideBar />
          <div className="block-container" id="setting">
            <h1 className="subheader">
              Assignment Name
            </h1>
            <p className="bodyText">
              Scheherazade, Op. 35
              Instrument
              Difficulty
            </p>
            <h2>Instructions</h2>
            <p className="bodyText">
            Here are some sample instructions.
            </p>
            <p>Feedback</p>
            <textarea name="feedback" className="feedback">
            </textarea>
            <button className="feedback-button">Send Feedback</button>
          </div>
        </div>
      </div>
    );
  }
}

export default GradeAssignmentView;
