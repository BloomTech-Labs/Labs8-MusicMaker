import React, { Component } from 'react';
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
  
  render() {
    return (
      <div className = 'flex-container'>
        <Sidebar />
    );
  }
}

export default GradeAssignmentView;
