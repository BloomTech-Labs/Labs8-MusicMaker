import React, { Component } from 'react';
import axios from 'axios';
import Sidebar from '../components/SideBar';
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

  componentDidMount() {
    axios
      .get('https://musicmaker-4b2e8.firebaseapp.com/studentendpointhere)
      .then(res => {
        console.log(res.data)
        this.setState({
          title: res.data.title,
          instrument: res.data.instrument,
          difficulty: res.data.difficulty
        })
      })
      .catch(err => console.error('An error was encountered.', err));
  } // this will not work until we have the student endpoints complete

  render() {
    return (
      <div className = 'flex-container'>
        <h1>Test</h1>
      </div>
    );
  }
}

export default GradeAssignmentView;
