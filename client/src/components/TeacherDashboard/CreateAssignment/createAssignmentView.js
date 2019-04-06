//Create Assignment View: This page will allow teacher's to create a new ungraded assignment.
//After the new assignment is created, it should direct you to the Assignments' Students List
//so that the teacher can add students to that assignment.

import React, { Component } from "react";
import { Input, Form, FormGroup, Button } from 'reactstrap';
import axios from 'axios';
import firebase from 'firebase';
// import { CreateAssignment } from "../HomeDashboard/HomeDashboardStyling";
import { CreateAssignmentContainer, H2 } from "./CreateAssignmentStyling";


 class CreateAssignmentView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      assignmentName: "",
      instructions: "",
      instrument: "",
      level: "",
      piece: "",
      sheetMusic: '', loaded: 0
    };
  };

  onChange = event => {
    this.setState({
      [event.target.name]: event.target.value,
    })
  }

  uploadChange = event => {
    this.setState({
      sheetMusic: event.target.files[0], loaded: 0,
    })
  }

  onSubmit = event => {
    event.preventDefault();

    const { assignmentName, piece, instrument, level, instructions, sheetMusic } = this.state;

    let formData = new FormData();

    formData.append('assignmentName', assignmentName);
    formData.append('piece', piece);
    formData.append('instrument', instrument);
    formData.append('level', level);
    formData.append('instructions', instructions);
    formData.append('file', sheetMusic);

    firebase.auth().onAuthStateChanged(user => {
      if (user) {
        // User is signed in.
        axios
        .post(`http://localhost:8000/teacher/${user.uid}/createAssignment`,
        // .post(`https://musicmaker-4b2e8.firebaseapp.com/${user.uid}/createAssignment`,
          formData
        )
        .then(res => {
          console.log("-->res", res);
          this.props.history.push(`/assignments`);
        })
        .catch(err => {
          console.error('CREATE ASSIGNMENT VIEW ERROR', err)
        })
      } else {
        // No user is signed in.
        return;
      }
    });
  }

  render() {
    const { assignmentName, piece, instructions } = this.state;

    return (
      <CreateAssignmentContainer>
        <Form onSubmit={this.onSubmit}>
          <H2>Create a New Assignment</H2>
          <FormGroup>
            <Input type="text" name="assignmentName" placeholder="Assignment Name" value={assignmentName} onChange={this.onChange} />
          </FormGroup>

          <FormGroup>
            <Input type="text" name="piece" placeholder="Piece Name" value={piece} onChange={this.onChange} />

            <Input type="select" name="instrument" onChange={this.onChange}>
              <option value="None">Choose Instrument</option>
              <option value="Drum">Drum</option>
              <option value="Guitar">Guitar</option>
              <option value="Piano">Piano</option>
              <option value="Saxophone">Saxophone</option>
              <option value="Trumpet">Trumpet</option>
              <option value="Violin">Violin</option>
            </Input>

            <Input type="select" name="level" onChange={this.onChange}>
              <option value="None">Choose Experience</option>
              <option value="Beginner">Beginner</option>
              <option value="Intermediate">Intermediate</option>
              <option value="Expert">Expert</option>
            </Input>
          </FormGroup>

          <FormGroup>
            <Input type="textarea" name="instructions" placeholder="Instructions..." value={instructions} onChange={this.onChange} style={{lineHeight:"2.125rem"}} />
          </FormGroup>

          <FormGroup style={{display:"flex"}}>
            <Input type ='file' name='sheetMusic' onChange={this.uploadChange} style={{fontWeight:"bold"}} />
            <Button type="submit" style={{padding:"0 5%"}}>Submit</Button>
          </FormGroup>

        </Form>
      </CreateAssignmentContainer>
    );
  }
}

export default CreateAssignmentView;
