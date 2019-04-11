//Grade Assignment View: This page will let teacher's see a student's assignment both completed and not completed.
//When the assignment is completed the teacher can see the assignment information and the students video to be able to 
//give the student feedback and a grade(Passed/Failed).
import React, { Component } from 'react';
import { Input, Form, FormGroup, Button } from 'reactstrap';
import axios from 'axios';
import firebase from 'firebase';


class GradeAssignmentView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      assignmentName: "",
      instructions: "",
      instrument: "",
      level: "",
      piece: "",
      sheetMusic: "",
      video:"",
      grade:"",
      feedback:""
    };
  };

  componentDidMount() {
    const assignmentId = this.props.match.params.assignmentId;
    const studentId = this.props.match.params.studentId;
    firebase.auth().onAuthStateChanged(user => {
      if (user) {
        // User is signed in.
        axios
          .get(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${user.uid}/assignment/${assignmentId}/student/${studentId}`)
          .then(res => {
            this.setState({
              assignmentName: res.data[0],
              instructions: res.data[5],
              instrument: res.data[2],
              level: res.data[3],
              piece: res.data[4],
              sheetMusic: res.data[6],
              video: res.data[7]
          })
      })
      .catch(err => console.error('An error was encountered.', err));
      } else {
        // No user is signed in.
        return;
      }
    });
    
  } 

  onChange = event => {
    this.setState({
      [event.target.name]: event.target.value,
    });
  };

  onSubmit = event => {
    event.preventDefault();

    firebase.auth().onAuthStateChanged(user => {
      if (user) {
        // User is signed in.
        const assignmentId = this.props.match.params.assignmentId;
        const studentId = this.props.match.params.studentId;

        const {feedback, grade} = this.state;

        axios
        .put(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${user.uid}/assignment/${assignmentId}/student/${studentId}`, {feedback, grade})
        .then(res => {
          this.props.history.push('/assignments') 
        })
        .catch(err => {
          console.err('GRADE ASSIGNMENT VIEW ERROR', err)
        })
      } else {
        // No user is signed in.
        return;
      }
    })
  }

  render() {
    const { assignmentName, instructions, instrument, level, piece, sheetMusic, video, feedback } = this.state;
   
    return (
      <div style={{width:"50%", margin:"3.5rem 0 0 25.25%", paddingBottom:"1.5rem", background:"#EBFAEF", border:"1px solid #a9e8dc"}}>
        <Form onSubmit={this.onSubmit}>
            <h2 style={{marginTop:"1.5rem", textAlign:"center"}}>{assignmentName}</h2>
            <FormGroup style={{display:"flex", flexDirection:"row", padding:"0 8%", marginTop:"1.5rem", justifyContent:"space-between"}}>
              {/* <p className="bodyText">{piece}</p> */}
              <p className="bodyText">{level}</p>
              <p className="bodyText">{instrument}</p>
              <p className="bodyText">{piece} <a href={sheetMusic}><img src={sheetMusic} alt="Music Sheet" /></a></p>
            </FormGroup>

            <p style={{width:"85%", margin:"0 8%"}}><span style={{fontWeight:"bold"}}>Instructions:</span> <br/> {instructions}</p>

            <FormGroup style={{display:"flex", flexDirection:"row", margin:"1.5rem 8%"}} >
            <a href={video} style={{fontSize:"1.25rem", paddingRight:"20%"}}><img src={video} alt="Recording" /></a>
            <Input style={{width:'28%', height:"1%"}}  type="select" name="grade" onChange={this.onChange}>
                <option value="none">Choose Grade</option>
                <option value="Passed">Passed</option>
                <option value="Failed">Failed</option>
            </Input>
            </FormGroup>

            <div style={{display:"flex", flexDirection:"row", margin:"0 8%", justifyContent:"space-between"}}>
              <Input style={{width:'75%'}} type="textarea" name="feedback" placeholder="Feedback..." value={feedback} onChange={this.onChange} />
              <Button type="submit" style={{float:"right", width:"15%", height:"100%"}}>Submit <br/> Feedback!</Button>
            </div>
        </Form>
      </div>
    );
  }
}

export default GradeAssignmentView;
