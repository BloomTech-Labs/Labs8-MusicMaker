//Grade Assignment View: This page will let teacher's see a student's assignment both completed and not completed.
//When the assignment is completed the teacher can see the assignment information and the students video to be able to 
//give the student feedback and a grade(Pass/Fail).
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
    // event.preventDefault();

    // const assignmentId = 'cKoEZeuuKdciV74U9pQq' //this.props.match.params.id;
    // const studentId = '7HTc3cy6GGPWtjqfpgMB3ij3wY92' //this.props.match.params.id;

    // const {feedback, grade} = this.state;

    // axios
    // .put(`https://musicmaker-4b2e8.firebaseapp.com/teacher/${teacherId}/assignment/${assignmentId}/student/${studentId}`, {feedback, grade})
    // .then(res => {
    //   console.log(res)
    //   this.props.history.push('/assignments') //may need to change?
    // })
    // .catch(err => {
    //   console.err('GRADE ASSIGNMENT VIEW ERROR', err)
    // })

  }

  render() {
    const { assignmentName, instructions, instrument, level, piece, sheetMusic, video, grade, feedback } = this.state;
    return (
      <div className="container">
        {/* <div className="flex-container"> */}
        <Form onSubmit={this.onSubmit}>
          <div className="block-container" id="setting">
            <h1 style={{textAlign:'center'}}>{assignmentName}</h1>
            <FormGroup style={{display:'flex', justifyContent:'space-between'}}>
              <p className="bodyText">{piece}</p>
              <p className="bodyText">{instrument}</p>
              <p className="bodyText">{level}</p>
              <p className="bodyText"><a href={sheetMusic}><img src={sheetMusic} alt="pdf image" /></a></p>
            </FormGroup>
            <FormGroup style={{display:'flex', flexDirection:'row', justifyContent:'space-between'}}>
            <div style={{width:'75%'}}><h6>Instructions:</h6>{instructions}</div>
            <p className="bodyText"><a href={video}><img src={video} alt="video image" /></a></p>
            </FormGroup>
            <FormGroup style={{display:'flex', justifyContent:'space-between'}}>
              <Input style={{width:'80%'}} type="textarea" name="feedback" placeholder="Feedback..." value={feedback} onChange={this.onChange} />
              <Input style={{width:'26%', marginLeft:'10%'}}  type="select" name="grade" onChange={this.onChange}>
                <option value="none">Choose Grade</option>
                <option value="Pass">Pass</option>
                <option value="Fail">Fail</option>
              </Input>
            </FormGroup>
            <Button type="submit">Submit</Button>
          </div>
        </Form>
      </div>
    );
  }
}

export default GradeAssignmentView;
