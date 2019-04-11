//Create Assignment View: This page will allow teacher's to create a new ungraded assignment.
//After the new assignment is created, it should direct you to the Assignments' Students List
//so that the teacher can add students to that assignment.

import React, { Component } from "react";
import { Input, Form, FormGroup, Button } from 'reactstrap';
import axios from 'axios';
import firebase from 'firebase';


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
      <div style={{width:"50%", margin:"3.5rem 0 0 25.25%", paddingBottom:"1.5rem", background:"#EBFAEF", border:"1px solid #a9e8dc"}}>
        <Form onSubmit={this.onSubmit}>
          <h2 style={{marginTop:"1.5rem", textAlign:"center"}}>Create a New Assignment</h2>
          
          <Input type="text" name="assignmentName" placeholder="Assignment Name" value={assignmentName} onChange={this.onChange}
          style={{width:"80%", display:"block", margin:"1rem auto"}}/>

          <FormGroup style={{display:"flex", flexDirection:"row", justifyContent:"space-between", margin:"0 10%"}}>
            <Input type="text" name="piece" placeholder="Piece Name" value={piece} onChange={this.onChange} style={{width:"30%"}}/>

            <Input type="select" name="instrument" onChange={this.onChange} style={{width:"30%"}}>
              <option value="None">Choose Instrument</option>
              <option value="Drum">Drum</option>
              <option value="Guitar">Guitar</option>
              <option value="Piano">Piano</option>
              <option value="Saxophone">Saxophone</option>
              <option value="Trumpet">Trumpet</option>
              <option value="Violin">Violin</option>
            </Input>

            <Input type="select" name="level" onChange={this.onChange} style={{width:"30%"}}>
              <option value="None">Choose Experience</option>
              <option value="Beginner">Beginner</option>
              <option value="Intermediate">Intermediate</option>
              <option value="Expert">Expert</option>
            </Input>
          </FormGroup>

          <Input type="textarea" name="instructions" placeholder="Instructions..." value={instructions} onChange={this.onChange} 
          style={{width:"80%", display:"block", margin:"1rem auto"}} />

          <FormGroup style={{display:"flex", margin:"0 10%"}}>
            <Input type ='file' name='sheetMusic' onChange={this.uploadChange} style={{fontWeight:"bold"}} />
            <Button type="submit" style={{padding:"0 5%"}}>Submit</Button>
          </FormGroup>

        </Form>
      </div>
    );
  }
}

export default CreateAssignmentView;
